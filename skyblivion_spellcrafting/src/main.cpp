#include "PCH.h"
#include "Spellmaking.h"
#include "SpellmakingMenu.h"

namespace
{
	void MessageHandler(SKSE::MessagingInterface::Message* a_msg)
	{
		switch (a_msg->type) {
		case SKSE::MessagingInterface::kDataLoaded:
			{
				Scaleform::SpellmakingMenu::Register();
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
		return false;
	}

	*path /= "SkyblivionSpellcrafting.log"sv;
	auto sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(path->string(), true);
#endif

	auto log = std::make_shared<spdlog::logger>("global log"s, std::move(sink));

#ifndef NDEBUG
	log->set_level(spdlog::level::trace);
#else
	log->set_level(spdlog::level::info);
	log->flush_on(spdlog::level::warn);
#endif

	spdlog::set_default_logger(std::move(log));
	spdlog::set_pattern("%g(%#): [%^%l%$] %v"s);

	logger::info("Skyblivion Spellcraft v0.1.0");

	a_info->infoVersion = SKSE::PluginInfo::kVersion;
	a_info->name = "SkyblivionSpellcraft";
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
	logger::info("Skyblivion Spellcrafting loaded");

	SKSE::Init(a_skse);

	auto messaging = SKSE::GetMessagingInterface();
	if (!messaging->RegisterListener("SKSE", MessageHandler)) {
		logger::critical("Could not register MessageHandler");
		return false;
	} else {
		logger::info("registered listener");
	}

	auto papyrus = SKSE::GetPapyrusInterface();
	if (!papyrus->Register(Scaleform::SpellmakingMenu::RegisterFuncs)) {
		return false;
	} else {
		logger::info("registered papyrus SpellcraftMenu funcs");
	}

	try {
		auto serialization = SKSE::GetSerializationInterface();
		serialization->SetUniqueID('SKBL');
		serialization->SetSaveCallback(Spellmaking::SaveCallback);
		serialization->SetLoadCallback(Spellmaking::LoadCallback);
		logger::info("registered spellmaking save callback");
	} catch (...) {
		logger::critical("something wrong in serialization callbacks");
		return false;
	}

	return true;
}
