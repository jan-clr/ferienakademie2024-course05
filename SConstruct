#!/usr/bin/env python
import os

def normalize_path(val, env):
    return val if os.path.isabs(val) else os.path.join(env.Dir("#").abspath, val)

def validate_parent_dir(key, val, env):
    if not os.path.isdir(normalize_path(os.path.dirname(val), env)):
        raise ValueError("'%s' is not a directory: %s" % (key, os.path.dirname(val)))

libnames = ["liba", "libb", "libgdkinect", "libpartsim"] # add additional libraries here
projectdir = "project"

localEnv = Environment(tools=["default"], PLATFORM="")

customs = ["custom.py"]
customs = [os.path.abspath(path) for path in customs]

opts = Variables(customs, ARGUMENTS)
opts.Add(
    BoolVariable(
        key="compiledb",
        help="Generate compilation DB (`compile_commands.json`) for external tools",
        default=localEnv.get("compiledb", False),
    )
)
opts.Add(
    PathVariable(
        key="compiledb_file",
        help="Path to a custom `compile_commands.json` file",
        default=localEnv.get("compiledb_file", "compile_commands.json"),
        validator=validate_parent_dir,
    )
)
opts.Update(localEnv)
Help(opts.GenerateHelpText(localEnv))

env = localEnv.Clone()
env["compiledb"] = False

env.Tool("compilation_db")
compilation_db = env.CompilationDatabase(
    normalize_path(localEnv["compiledb_file"], localEnv)
)
env.Alias("compiledb", compilation_db)

env = SConscript("godot-cpp/SConstruct", {"env": env, "customs": customs})


# For reference:
# - CCFLAGS are compilation flags shared between C and C++
# - CFLAGS are for C-specific compilation flags
# - CXXFLAGS are for C++-specific compilation flags
# - CPPFLAGS are for pre-processor flags
# - CPPDEFINES are for pre-processor defines
# - LINKFLAGS are for linking flags

libnames = ["liba", "libb", "libgdkinect"] # add additional libraries here
projectdir = "project"

match env["platform"]:
    case "linux": libusb_path = "/usr/include/libusb-1.0"
    case "windows": libusb_path = "/usr/x86_64-w64-mingw32/include/libusb-1.0"
    case "macos": libusb_path = "/opt/homebrew/include/libusb-1.0"

env.Append(CPPPATH=["src/", libusb_path, "libfreenect/include", "libfreenect/wrappers/cpp", "libfreenect/src"])
env.Append(CPPFLAGS=["-fexceptions"])
env.Append(LIBS=["freenect"])
env.Append(LIBPATH=["project/bin"])
sources = Glob("src/*.cpp")

env.Append(CCFLAGS=["-fopenmp"])
env.Append(LINKFLAGS=["-fopenmp"])

targetPath = "{}/bin/".format(projectdir)

for libname in libnames:
    file = "{}{}{}".format(libname, env["suffix"], env["SHLIBSUFFIX"])
    print(f"Building file {file}")

    libraryfile = "{}/{}".format(targetPath, file)
    library = env.SharedLibrary(
        libraryfile,
        source=sources,
    )
    print(f"Installing as {projectdir}/bin/lib{file}")
    copy = env.InstallAs("{}/bin/lib{}".format(projectdir, file), library)

    default_args = [library, copy]
    if localEnv.get("compiledb", False):
        default_args += [compilation_db]
    Default(*default_args)

