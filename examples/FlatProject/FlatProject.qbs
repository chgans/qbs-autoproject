import qbs

Project
{
    name: "FlatProject"
    id: flatproject
    property path targetDir: [qbs.targetOS, qbs.toolchain.join("-")].join("-")

    Project
    {
        name: "Library"

        DynamicLibrary
        {
            Export
            {
                Depends { name: "cpp" }
                Depends { name: "Qt.core" }
                cpp.includePaths: ["."]
            }

            name: "Library"
            Depends { name: "cpp" }
            Depends { name: "Qt.core" }
            cpp.includePaths: ["."]
            files: ["Library.h", "Library.cpp"]

            Group
            {
                qbs.install: true
                qbs.installDir: flatproject.targetDir
                fileTagsFilter: "dynamiclibrary"
            }
        }

        QtApplication
        {
            Depends { name: "Library" }
            Depends { name: "Qt.testlib" }

            name: "LibraryTest"
            files: ["LibraryTest.cpp"]

            Group
            {
                qbs.install: true
                qbs.installDir: flatproject.targetDir
                fileTagsFilter: "application"
            }
        }
    }

    Project
    {
        name: "OtherLibrary"

        DynamicLibrary
        {
            Export
            {
                Depends { name: "cpp" }
                cpp.includePaths: ["."]
            }

            name: "OtherLibrary"
            Depends { name: "cpp" }
            cpp.includePaths: ["."]
            files: ["OtherLibrary.h", "OtherLibrary.cpp"]

            Group
            {
                qbs.install: true
                qbs.installDir: flatproject.targetDir
                fileTagsFilter: "dynamiclibrary"
            }
        }

        QtApplication
        {
            Depends { name: "OtherLibrary" }
            Depends { name: "Qt.testlib" }

            name: "OtherLibraryTest"
            files: ["OtherLibraryTest.cpp"]

            Group
            {
                qbs.install: true
                qbs.installDir: flatproject.targetDir
                fileTagsFilter: "application"
            }
        }
    }

    QtApplication
    {
        Depends { name: "OtherLibrary" }
        Depends { name: "Library" }

        name: "FlatProject"
        files: ["main.cpp"]
        cpp.cxxLanguageVersion: "c++1z"

        Group
        {
            qbs.install: true
            qbs.installDir: flatproject.targetDir
            fileTagsFilter: "application"
        }
    }

    Product
    {
        Depends { name: "Qt.core" }
        builtByDefault: false
        type: "qch"
        name: "Documentation"
        files: ["*.qdoc"]

        Group
        {
            files: ["*.qdocconf"]
            fileTags: "qdocconf-main"
        }

        Group
        {
            fileTagsFilter: ["qdoc-output"]
            qbs.install: true
            qbs.installDir: "doc"
            qbs.installSourceBase: Qt.core.qdocOutputDir
        }

        Group
        {
            fileTagsFilter: ["qch"]
            qbs.install: true
            qbs.installDir: "doc"
        }
    }
}