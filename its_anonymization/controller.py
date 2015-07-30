from myXMLParser import XMLParser2
from myConfig import MyConfig
from configInfo import ConfigInfo
import os


class Controller:
    def __init__(self):
        self.my_conf = MyConfig()
        self.conf_info = ConfigInfo()

        self.my_conf.json_reader('configs')
        for i in self.my_conf.content:
            self.conf_info.set_config(i, self.my_conf.content[i][0],
                                      self.my_conf.content[i][1])
        self.folder = ""
        self.overview = []

    def get_conf_item(self, index):
        return self.conf_info.items[index]

    def get_conf_config(self, key):
        return self.conf_info.get_config(key)[0]

    def get_conf_value(self, key):
        return self.conf_info.get_config(key)[1]

    def set_conf_config(self, key, config, value=None):
        self.conf_info.set_config(key, config, value)

    def get_conf_exp(self, key):
        return self.conf_info.get_exp(key)

    def save_config(self):
        self.my_conf.json_writer('configs', self.conf_info.config)

    def set_files(self, path):
        self.folder = path

    def apply_file(self, filename):
        parser = XMLParser2(filename)
        items = self.conf_info.items
        new_folder = os.path.dirname(filename) + '_processed/'
        message = [os.path.basename(filename)]

        for i in items:
            config = self.get_conf_config(i)
            xpaths = self.conf_info.get_path(i)
            fill = True

            if config == 1:
                for j in xpaths:
                    old_value = parser.get_attr(j[0], j[1])
                    self.conf_info.set_original(i, old_value)
                    parser.del_attrs(j[0], j[1])
                    if fill:
                        message.append(old_value)
                        fill = False
            elif config == 2:
                for j in xpaths:
                    old_value = parser.get_attr(j[0], j[1])
                    self.conf_info.set_original(i, old_value)
                    new_value = self.conf_info.get_fuzzy(i)
                    parser.set_attrs(j[0], j[1], new_value)
                    if fill:
                        message.append(old_value)
                        message.append(new_value)
                        fill = False

        self.overview.append(message)
        parser.save(new_folder + os.path.basename(filename))

    def run(self):
        if len(self.folder) == 0:
            return 1
        if len(self.conf_info.config) == 0:
            return 2

        new_folder = self.folder + "_processed/"
        if not os.path.isdir(new_folder):
            os.mkdir(new_folder)

        message = ['filename']

        for i in self.conf_info.items:
            config = self.get_conf_config(i)
            if config == 1:
                message.append(i)
            elif config == 2:
                message.append(i+'(old)')
                message.append(i+'(new)')
        self.overview.append(message)

        file_list = os.listdir(self.folder)
        for x in file_list:
            self.apply_file(self.folder + '/' + x)

        self.my_conf.csv_writer(new_folder + 'overview.csv', self.overview)

        return 0
