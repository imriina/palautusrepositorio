from urllib import request
from project import Project
import tomli


class ProjectReader:
    def __init__(self, url):
        self._url = url

    def get_project(self):
        # tiedoston merkkijonomuotoinen sisältö
        content = request.urlopen(self._url).read().decode("utf-8")
        print(content)


        data = tomli.loads(content)



        
        name = data["tool"]["poetry"]["name"]
        description = data["tool"]["poetry"]["description"]
        dependencies = list(data["tool"]["poetry"]["dependencies"].keys())
        dev_dependencies = list(data["tool"]["poetry"]["group"]["dev"]["dependencies"].keys())



        # deserialisoi TOML-formaatissa oleva merkkijono ja muodosta Project-olio sen tietojen perusteella
        return Project(name, description, dependencies, dev_dependencies)
    
        
