import time
import datetime
from dateutil.relativedelta import relativedelta

PATH_DICT = {'Serial Number':
             [('./ProcessingUnit/UPL_Header/TransferredUPL/RecorderInformation/SRDInfo', 'SerialNumber')],
             'Gender': [('./ExportData/Child', 'Gender'),
                        ('./ProcessingUnit/ChildInfo', 'gender'),
                        ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'Gender')],
             'Algorithm Age': [('./ChildInfo', 'algorithmAge')],
             'Child ID': [('./ExportData/Child', 'id')],
             'Child Key': [('./ExportData/Child', 'ChildKey'),
                           ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'ChildKey')],
             'Enroll Date': [('./ExportData/Child', 'EnrollDate')],
             'DOB': [('./ExportData/Child', 'DOB'),
                     ('./ProcessingUnit/UPL_Header/TransferredUPL/ApplicationData/PrimaryChild', 'DOB')],
             'Time Zone': [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime',
                            'TimeZone')],
             'UTC Time': [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime',
                           'UTCTime')],
             'Clock Time':
             [('./ProcessingUnit/UPL_Header/TransferredUPL/RecordingInformation/TransferTime', 'LocalTime'),
              ('./ProcessingUnit/Bar', 'startClockTime'),
              ('./ProcessingUnit/Recording', 'startClockTime'),
              ('./ProcessingUnit/Recording', 'endClockTime'),
              ('./ProcessingUnit/Bar/Recording', 'startClockTime'),
              ('./ProcessingUnit/Bar/Recording', 'endClockTime'),
              ('./ProcessingUnit/Bar/FiveMinuteSection', 'startClockTime'),
              ('./ProcessingUnit/Bar/FiveMinuteSection', 'endClockTime'),
              ('./ProcessingUnit/UPL_SectorSummary/Item', 'timeStamp')]}

EXAMPLE_DICT = {"Serial Number": "Serial number for the DLP. Fuzz replaces the value with 0 or specified new values.",
                "Algorithm Age": "Used by LENA in its processing of the UPL files, not an exact age.",
                "Gender": "Gender information",
                "Child ID": "For exporting and processing, fuzz replaces the value with 0 or specified new values.",
                "Child Key": "For exporting and processing, fuzz replaces the value with 0 or specified new values.",
                "Enroll Date": "This was input into LENA's system. It is recommended to delete this.",
                "DOB": "Fuzz replaces the value of DOB with January, 1, 2000 or specified new values. All Clock time will be calculated based on DOB and old clock time",
                "Time Zone": "Time Zone information",
                "UTC Time": "UTC Time information",
                "Clock Time": "example"}


class ConfigInfo:
    def __init__(self):
        self.items = ["Serial Number", "Gender", "Algorithm Age",
                      "Child ID", "Child Key", "Enroll Date", "DOB",
                      "Time Zone", "UTC Time", "Clock Time"]

        # 0-keep, 1-delete, 2-change
        self.config = {}
        self.original = {}

    def get_path(self, key):
        return PATH_DICT[key]

    def set_config(self, key, config, value=None):
        if value is None:
            self.config[key][0] = config
        else:
            self.config[key] = [config, value]

    def get_config(self, key):
        return self.config[key]

    def set_original(self, key, value):
        self.original[key] = value

    def get_original(self, key):
        return self.original[key]

    def get_exp(self, key):
        return EXAMPLE_DICT[key]

    def get_fuzzy(self, key):
        value = " "

        if key == 'Clock Time':
            # example: 2015-06-10T11:30:20Z
            if self.original['Clock Time'][-1] == 'Z':
                clock_time = datetime.datetime.strptime(self.original['Clock Time'], "%Y-%m-%dT%H:%M:%SZ")
            else:
                clock_time = datetime.datetime.strptime(self.original['Clock Time'], "%Y-%m-%dT%H:%M:%S")
            dob_time = datetime.datetime.strptime(self.original['DOB'], "%Y-%m-%d")
            new_time = datetime.date(2000, 01, 01) + relativedelta(clock_time, dob_time)

            if self.original['Clock Time'][-1] == 'Z':
                value = new_time.strftime("%Y-%m-%dT%H:%M:%SZ")
            else:
                value = new_time.strftime("%Y-%m-%dT%H:%M:%S")
        else:
            value = self.config[key][1]

        return value
