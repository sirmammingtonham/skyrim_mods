﻿#include "BirthsignMenu.h"
#include "PCH.h"

namespace
{
	void MessageHandler(SKSE::MessagingInterface::Message* a_msg)
	{
		switch (a_msg->type) {
		case SKSE::MessagingInterface::kDataLoaded:
			{
				Scaleform::BirthsignMenu::Register();
			}
			break;
		}
	}
}

extern "C" DLLEXPORT bool SKSEAPI SKSEPlugin_Query(const SKSE::QueryInterface* a_skse, SKSE::PluginInfo* a_info)
{
#ifndef NDEBUG
		auto sink = std::make_shared<spdlog::sinks::msvc_sink_mt>();
#else
		auto path = logger::log_directory();
		if (!path) {
			util::report_and_fail("Failed to find standard logging directory"sv);
		}

		*path /= fmt::format("{}.log"sv, Plugin::NAME);
		auto sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(path->string(), true);
#endif

#ifndef NDEBUG
		const auto level = spdlog::level::trace;
#else
		const auto level = spdlog::level::info;
#endif

		auto log = std::make_shared<spdlog::logger>("global log"s, std::move(sink));
		log->set_level(level);
		log->flush_on(level);

		spdlog::set_default_logger(std::move(log));
		spdlog::set_pattern("%g(%#): [%^%l%$] %v"s);

	logger::info("Skywind Birthsign v0.1.0");

	a_info->infoVersion = SKSE::PluginInfo::kVersion;
	a_info->name = "SkywindBirthsign";
	a_info->version = 1;

	if (a_skse->IsEditor()) {
		logger::critical("Loaded in editor, marking as incompatible"sv);
		return false;
	}

	const auto ver = a_skse->RuntimeVersion();
	if (ver < SKSE::RUNTIME_1_5_39) {
		logger::critical("Unsupported runtime version {}", ver.string());
		return false;
	}

	return true;
}

extern "C" DLLEXPORT bool SKSEAPI SKSEPlugin_Load(const SKSE::LoadInterface* a_skse)
{
	logger::info("Skywind Birthsign loaded");

	SKSE::Init(a_skse);

	auto messaging = SKSE::GetMessagingInterface();
	if (!messaging->RegisterListener("SKSE", MessageHandler)) {
		logger::critical("Could not register MessageHandler");
		return false;
	} else {
		logger::info("registered listener");
	}

	auto papyrus = SKSE::GetPapyrusInterface();
	if (!papyrus->Register(Scaleform::BirthsignMenu::RegisterFuncs)) {
		return false;
	} else {
		logger::info("registered papyrus Birthsign funcs");
	}

	return true;
}