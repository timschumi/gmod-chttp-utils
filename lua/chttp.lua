-- chttp.lua
--
-- Wrappers and utility functions for CHTTP

-- Don't overwrite an old version of the module
if chttp then return chttp end

local function getLibExt()
	local os = jit.os
	local arch = jit.arch

	if os == "Windows" and arch == "x86" then
		return "win32"
	elseif os == "Windows" and arch == "x64" then
		return "win64"
	elseif os == "Linux" and arch == "x86" then
		return "linux"
	elseif os == "Linux" and arch == "x64" then
		return "linux64"
	else
		return nil
	end
end

if not pcall(require, "chttp") or CHTTP == nil then
	if CHTTP_SILENT then
		return
	end

	local libname = getLibExt()

	ErrorNoHalt("[chttp-utils] Could not load CHTTP!\n")

	if not libname then
		print("[chttp-utils] According to the OS information provided (" .. jit.os .. "/" .. jit.arch .. "), your system is not supported by CHTTP.")
		print("[chttp-utils] If this is incorrect, please file a bug report on the GitHub page (https://github.com/timschumi/gmod-chttp-utils/issues).")
		return
	end

	print("[chttp-utils] Please make sure that `gmsv_chttp_" .. libname .. ".dll` is present in `/garrysmod/lua/bin`.")

	if jit.os == "Linux" then
		print("[chttp-utils] Make sure to also try the -static libraries that are available on the Downloads page (https://github.com/timschumi/gmod-chttp/releases), but keep in mind to rename them!")
	end

	print("[chttp-utils] If you are absolutely sure that this should work (or you exhausted all other options), feel free to file a bug report on the GitHub page (https://github.com/timschumi/gmod-chttp/issues).")
	return
end

chttp = {}

function chttp.Fetch(url, onSuccess, onFailure, headers)
	CHTTP({
		method = "get",
		url = url,
		success = function(code, body, headers)
			if not onSuccess then
				return
			end

			onSuccess(body, string.len(body), headers, code)
		end,
		failed = function(error)
			if not onFailure then
				return
			end

			onFailure(error)
		end,
		headers = headers or {},
	})
end

function chttp.Post(url, parameters, onSuccess, onFailure, headers)
	CHTTP({
		method = "post",
		url = url,
		parameters = parameters,
		success = function(code, body, headers)
			if not onSuccess then
				return
			end

			onSuccess(body, string.len(body), headers, code)
		end,
		failed = function(error)
			if not onFailure then
				return
			end

			onFailure(error)
		end,
		headers = header or {},
	})
end

return chttp
