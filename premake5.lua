project "OptickCore"
	uuid "830934D9-6F6C-C37D-18F2-FB3304348F00"
    language "C++"
	systemversion "latest"
    cppdialect "C++11"

	flags { "NoManifest", "FatalWarnings" }
	warnings "Extra"
    symbols "On"

	buildoptions { 
		"/wd4127", -- Conditional expression is constant
		"/wd4091"  -- 'typedef ': ignored on left of '' when no variable is declared
	}

	defines { "USE_OPTICK=1"}
	defines { "OPTICK_FIBERS=1"}
	defines { "_CRT_SECURE_NO_WARNINGS", "OPTICK_LIB=1" }

 	kind "SharedLib"
 	defines { "OPTICK_EXPORTS" }

	includedirs
	{
		"src"
	}
	
	-- if isDX12 then
	-- --	includedirs
	-- --	{
	-- --		"$(DXSDK_DIR)Include",
	-- --	}
	-- 	links { 
	-- 		"d3d12", 
	-- 		"dxgi",
	-- 	}
	-- else
		defines { "OPTICK_ENABLE_GPU_D3D12=0" }
	-- end
	
	-- if isVulkan then
	-- 	includedirs
	-- 	{
	-- 		"$(VULKAN_SDK)/Include",
	-- 	}
	-- 	libdirs {
	-- 		"$(VULKAN_SDK)/Lib",
	-- 	}
	-- 	links { 
	-- 		"vulkan-1",
	-- 	}
	-- else
		defines { "OPTICK_ENABLE_GPU_VULKAN=0" }
	-- end
	
	files {
		"src/**.cpp",
        "src/**.h", 
	}
	vpaths {
		["api"] = { 
			"src/optick.h",
			"src/optick.config.h",
		},
	}

    configuration "Release"
        defines { "NDEBUG", "MT_INSTRUMENTED_BUILD" }
        flags { optimization_flags }
        optimize "Speed"

    configuration "Debug"
        defines { "_DEBUG", "_CRTDBG_MAP_ALLOC", "MT_INSTRUMENTED_BUILD" }
