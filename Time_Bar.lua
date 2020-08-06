script_name('Time_Bar') -- �������� �������
script_author('Cat_Mav') -- ����� �������

require "lib.moonloader"
local dlstatus = require('moonloader').download_status
local key = require 'vkeys'
local imgui = require 'imgui'
local encoding = require 'encoding'
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_vers = 2
local script_vers_text = "1.05"

local update_url = "https://raw.githubusercontent.com/CatMav228/Scripts/master/Update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/Update.ini" -- � ��� ���� ������

local script_url = "https://github.com/CatMav228/Scripts/raw/master/Dadaya.lua" -- ��� ���� ������
local script_path = thisScript().path

local cb_show_cursor = imgui.ImBool(imgui.ShowCursor)


main_window_state = imgui.ImBool(false)

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	sampRegisterChatCommand("tmbar", cmd_hotkey)
	
	 sampRegisterChatCommand("update", cmd_update)
	    thread = lua_thread.create_suspended(thread_function)

	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)

    imgui.Process = false
	
	

    sampAddChatMessage('{FF0000}TimeBar Loaded | Activations: /tmbar')
	wait(5000)
	sampAddChatMessage('{FF0000}TM | N��� ��������� ������� ��� ��� ������.')
    wait(5000)
	sampAddChatMessage('{FF0000}TM | E��� ������ �� ���������, ��������� /reload ��� /rlt [��� ������� ����� ReloadScripts.lua]')
	wait(5000)
	sampAddChatMessage('{FF0000}TM | ������� ����: https://yadi.sk/d/B3IzqOWkt1jPcg')
	wait(5000)
	sampAddChatMessage('{FF0000}TM | ���������: ���� ReloadScripts.lua ����������� � ����� Moonloader')

downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    
	while true do
        wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ ������� ��������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end

	end
end

function cmd_update(arg)
    sampShowDialog(1000, "�������������� v2.0", "{FFFFFF}��� ���� �� ����������\n{FFF000}����� ������", "�������", "", 0)
end

function cmd_hotkey(arg)
	main_window_state.v = not main_window_state.v
	imgui.Process = main_window_state.v
end


function imgui.OnDrawFrame()

	if not main_window_state.v then
		imgui.Process = false
	end

    if main_window_state.v then
		local sw, sh = getScreenResolution()

      

		imgui.Begin(u8'TimeBar', main_window_state, imgui.WindowFlags.NoCollapse)
		imgui.Text(u8"Time: "..os.date('%H:%M  %x'))
		imgui.Text('Days: '..os.date('%A'))
		imgui.Separator()
		imgui.Text('Nick_Name: '.. nick)
		imgui.Text('ID: '.. id)
		

        imgui.End()
    end

end

