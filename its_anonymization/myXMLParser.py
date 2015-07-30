import xml.etree.cElementTree as ET


# incremental xml parser
class XMLParser:
    def __init__(self, filename):
        self.tree = ET.iterparse(filename, events=('start', 'end'))
        self.parse()

    def parse(self):
        for event, elem in self.tree:
            if event == 'end':
                elem.clear()


# normal xml parser, read the xml file into memory
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
