import qbs
import qbs.FileInfo

StaticLibrary
{
    property stringList paths: []
    targetName: qbs.buildVariant == "debug" ? name + "d" : name

    files:
    {
        var list = [];
        for(var i in paths)
            list.push(paths[i] + "/*");
        return list;
    }
            
    Group
    {
        qbs.install: true
        qbs.installDir: project.installDirectory
        fileTagsFilter: ["staticlibrary"]
    }
}
