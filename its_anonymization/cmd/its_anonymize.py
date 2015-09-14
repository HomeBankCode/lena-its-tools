import glob
import os
import xml.etree.cElementTree as ET
import time
import datetime
from dateutil.relativedelta import relativedelta
import csv


# default configurations for domain items
# 0 - keep
# 1 - delete
# 2 - use dummy value
CONF_DICT = {
    "Serial Number": [2, "0000"],
    "Gender": [0, -1],
    "Algorithm Age": [0, -1],
    "Child ID": [2, "0000"],
    "Child Key": [2, "0000000000000000"],
    "Enroll Date": [1, -1],
    "DOB": [2, "2000-01-01"],
    "Time Zone": [1, -1],
    "UTC Time": [1, -1],
    "Clock Time": [2, "0"]
}

# path dictionary for domain items in ITS files.
# key - internal name
# value[0] - xpath
# value[1] - xml tag
PATH_DICT = {
    'Serial Number':[('./ProcessingUnit/UPL_Header/TransferredUPL/RecorderInformation/SRDInfo', 'SerialNumber')],
    'Gender': [('./ExportData/Child', 'Gender'), ('./ProcessingUnit/ChildInfo', 'gender'),
               ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'Gender')],
    'Algorithm Age': [('./ChildInfo', 'algorithmAge')],
    'Child ID': [('./ExportData/Child', 'id')],
    'Child Key': [('./ExportData/Child', 'ChildKey'), ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'ChildKey')],
    'Enroll Date': [('./ExportData/Child', 'EnrollDate')],
    'DOB': [('./ExportData/Child', 'DOB'), ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'DOB')],
    'Time Zone': [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime', 'TimeZone')],
    'UTC Time': [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime', 'UTCTime')],
    'Clock Time':
             [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime', 'LocalTime'),
              ('./ProcessingUnit/Bar', 'startClockTime'),
              ('./ProcessingUnit/Recording', 'startClockTime'),
              ('./ProcessingUnit/Recording', 'endClockTime'),
              ('./ProcessingUnit/Bar/Recording', 'startClockTime'),
              ('./ProcessingUnit/Bar/Recording', 'endClockTime'),
              ('./ProcessingUnit/Bar/FiveMinuteSection', 'startClockTime'),
              ('./ProcessingUnit/Bar/FiveMinuteSection', 'endClockTime'),
              ('./ProcessingUnit/UPL_SectorSummary/Item', 'timeStamp')]
}


#  xml parser, read the xml file into memory
class XMLParser2:
    def __init__(self, filename):
        self.tree = ET.parse(filename)
        self.root = self.tree.getroot()
        self.filename = filename

    def get_attrs(self, xpath, key):
        node_list = self.root.findall(xpath)
        return [x.attrib[key] for x in node_list]

    def get_attr(self, xpath, key):
        node = self.root.find(xpath)
        return node.attrib[key]

    def set_attrs(self, path, key, value):
        node_list = self.root.findall(path)

        for x in node_list:
            x.attrib[key] = value

    def del_attrs(self, path, key):
        node_list = self.root.findall(path)
        for x in node_list:
            del x.attrib[key]

    def save(self, filename):
        self.tree.write(filename)


def csv_writer(filename, data):
    with open(filename, 'wb') as fp:
        writer = csv.writer(fp, quoting=csv.QUOTE_ALL)
        for row in data:
            writer.writerow(row)


# main entrance for script
class Main:
    def __init__(self):
        self.items = ["Serial Number",
                      "Gender",
                      "Algorithm Age",
                      "Child ID",
                      "Child Key",
                      "Enroll Date",
                      "DOB",
                      "Time Zone",
                      "UTC Time",
                      "Clock Time"]
        self.output_path = os.getcwd() + '/' + "output"
        self.items_original = {}
        self.overview = []

    def run(self):
        if not os.path.exists(self.output_path):
            os.makedirs(self.output_path)

        # save to overview file
        text = ['filename']
        for i in self.items:
            config = CONF_DICT[i][0]
            # if delete, only show original.
            if config == 1:
                text.append(i)
            # if change, show old value and new value.
            elif config == 2:
                text.append(i + '_origin')
                text.append(i + '_new')
        self.overview.append(text)

        for name in glob.glob('*.its'):
            print name
            self.filter(name)

        csv_writer(self.output_path + '/' + 'overview.csv', self.overview)

    def filter(self, filename):
        parser = XMLParser2(filename)
        text = [filename]

        for i in self.items:
            config = CONF_DICT[i][0]
            xpaths = PATH_DICT[i]
            # delete
            if config == 1:
                for j in xpaths:
                    self.items_original[i] = parser.get_attr(j[0], j[1])
                    parser.del_attrs(j[0], j[1])
                    # only put first item in overview
                    if xpaths.index(j) == 0:
                        text.append(self.items_original[i])
            # change
            elif config == 2:
                for j in xpaths:
                    self.items_original[i] = parser.get_attr(j[0], j[1])
                    new_value = self.dummy(i)
                    parser.set_attrs(j[0], j[1], new_value)
                    # only put first item in overview
                    if xpaths.index(j) == 0:
                        text.append(self.items_original[i])
                        text.append(new_value)
        self.overview.append(text)
        parser.save(self.output_path + '/' + filename)

    def dummy(self, key):
        value = " "

        # new clock time will calculate base on the DOB.
        if key == 'Clock Time':
            # example: 2015-06-10T11:30:20Z
            if self.items_original['Clock Time'][-1] is 'Z':
                clock_time = datetime.datetime.strptime(self.items_original['Clock Time'],
                                                        "%Y-%m-%dT%H:%M:%SZ")
            else:
                clock_time = datetime.datetime.strptime(self.items_original['Clock Time'],
                                                        "%Y-%m-%dT%H:%M:%S")

            dob_time = datetime.datetime.strptime(self.items_original['DOB'], "%Y-%m-%d")
            new_time = datetime.date(2000, 01, 01) + relativedelta(clock_time, dob_time)

            if self.items_original['Clock Time'][-1] is 'Z':
                value = new_time.strftime("%Y-%m-%dT%H:%M:%SZ")
            else:
                value = new_time.strftime("%Y-%m-%dT%H:%M:%S")
        else:
            value = CONF_DICT[key][1]

        return value


if __name__ == '__main__':
    main = Main()
    main.run()
    print 'done!'
