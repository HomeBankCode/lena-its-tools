import csv
import json


class MyConfig:
    def __init__(self):
        self.content = {}

    def json_reader(self, filename):
        with open(filename, 'rb') as fp:
            self.content = json.load(fp)

    def json_writer(self, filename, data=None):
        with open(filename, 'wb') as fp:
            res = data
            if data is None:
                res = self.content
            json.dump(res, fp)

    def change_config(self, key, value):
        self.content[key] = value

    def csv_reader(self, filename):
        with open(filename, 'rb') as fp:
            reader = csv.reader(fp)
            for row in reader:
                self.content.append(row)

    def csv_writer(self, filename, data=None):
        with open(filename, 'wb') as fp:
            res = data
            if data is None:
                for key, value in self.content:
                    tmp = [key, value]
                    res.append(tmp)
            writer = csv.writer(fp, quoting=csv.QUOTE_ALL)
            for row in res:
                writer.writerow(row)

# myDict={
#     "Serial Number": (2, '0000'),
#     "Gender": (0, -1),
#     "Algorithm Age": (0, -1),
#     "Child ID": (1, '0000'),
#     "Child Key": (1, '0000000000000000'),
#     "Enroll Date": (1, -1),
#     "DOB": (1, '1900-01-01'),
#     "Time Zone": (1, -1),
#     "UTC Time": (1, -1),
#     "Clock Time": (1, '0')
# }

# config = MyConfig()
# config.json_writer('configs', myDict)
