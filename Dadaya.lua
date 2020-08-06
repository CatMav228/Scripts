script_name('Helper')
script_author('Dadaya')
script_description('Demonstrates Moon ImGui features')

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
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "" -- ��� ���� ������
local script_path = thisScript().path

local themes = import "resource/imgui_themes.lua"


main_window_state = imgui.ImBool(false)


function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	-- style.Alpha =
	-- style.WindowPadding =
	-- style.WindowMinSize =
	-- style.FramePadding =
	-- style.ItemInnerSpacing =
	-- style.TouchExtraPadding =
	-- style.IndentSpacing =
	-- style.ColumnsMinSpacing = ?
	-- style.ButtonTextAlign =
	-- style.DisplayWindowPadding =
	-- style.DisplaySafeAreaPadding =
	-- style.AntiAliasedLines =
	-- style.AntiAliasedShapes =
	-- style.CurveTessellationTol =

	colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
            colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
            colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
            colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
            colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
            colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
            colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
            colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
            colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
            colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
            colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
            colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
            colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
            colors[clr.Separator]              = colors[clr.Border]
            colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
            colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
            colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
            colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
            colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
            colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
            colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
            colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.TextDisabled]           = ImVec4(0.20, 0.20, 0.20, 1.00)
            colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
            colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.ComboBg]                = colors[clr.PopupBg]
            colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.20, 0.20)
            colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.20)
            colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
            colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
            colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

apply_custom_style()

do

show_main_window = imgui.ImBool(false)
local show_imgui_example = imgui.ImBool(false)
local slider_float = imgui.ImFloat(0.0)
local clear_color = imgui.ImVec4(0.45, 0.55, 0.60, 1.00)
local show_test_window = imgui.ImBool(false)
local show_another_window = imgui.ImBool(false)
local show_window = imgui.ImBool(false)
local show_moon_imgui_tutorial = {imgui.ImBool(false), imgui.ImBool(false), imgui.ImBool(false)}
local text_buffer = imgui.ImBuffer('', 256)
local text_buffer_rep = imgui.ImBuffer('', 256)
local text_buffer_r = imgui.ImBuffer('', 256)
local text_buffer_time = imgui.ImBuffer('', 256)
local text_buffer_suspeckt = imgui.ImBuffer('', 256)
local text_buffer_helper = imgui.ImBuffer('', 256)
local text_buffer_helper_id = imgui.ImBuffer('', 256)
local text_buffer_helper_vvod = imgui.ImBuffer('', 256)
local sampgui_texture = nil
local veh = storeCarCharIsInNoSave(PLAYER_PED)
local _, id = sampGetPlayerIdByCharHandle(ped)
local cb_render_in_menu = imgui.ImBool(imgui.RenderInMenu)
local cb_lock_player = imgui.ImBool(imgui.LockPlayer)
local cb_show_cursor = imgui.ImBool(imgui.ShowCursor)
local glyph_ranges_cyrillic = nil
local checked_radio = imgui.ImInt(2)
local checked_radio_pol = imgui.ImInt(3)
-- combo
local combo_report = imgui.ImInt(0)
local show_helper_menu = imgui.ImBool(false)
local combo_pol = imgui.ImInt(0)


 -- Pilot 
 local show_pilot_window = imgui.ImBool(false)
 local show_pilot_puti = imgui.ImBool(false)
 -- ���������
 local show_dokumenti = imgui.ImBool(false)
 -- ��������
 local show_license = imgui.ImBool(false)
 -- �����������
 local check_antibiotiki = imgui.ImBool(false)
 -- ���
 local show_report = imgui.ImBool(false)
 local show_yakuza = imgui.ImBool(false)
-- ��������
local show_anims = imgui.ImBool(false)
-- ����
local show_bank_menu = imgui.ImBool(false)
-- �������
local show_police_menu = imgui.ImBool(false)
-- �����
local show_marry_menu = imgui.ImBool(false)
-- ��
local show_ap_menu = imgui.ImBool(false)
local show_report_menu = imgui.ImBool(false)
-- ���
local show_vmf_menu = imgui.ImBool(false)
-- �����
local show_pesni_menu = imgui.ImBool(false)
local show_menu_tems = imgui.ImBool(false)
--------------------------------------------
local show_timebar = imgui.ImBool(false)
function imgui.OnDrawFrame()
local arr_pol = {u8"�������", u8"�������"}
-- imgui.NextColumn()
	-- Main Window
	if show_main_window.v then
		local sw, sh = getScreenResolution()

		-- center END key
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.3, sh / 1.3), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(750, 300), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' ������ �������', show_main_window)
		local framerate = imgui.GetIO().Framerate
		local btn_size = imgui.ImVec2(-0.1, 0)
		
	     imgui.BeginChild("ChildWindow2007", imgui.ImVec2(140, 270), true)
		
		
		if imgui.Button('EXM Panel', imgui.ImVec2(130, 20)) then
			show_imgui_example.v = not show_imgui_example.v
		end


         if imgui.Button(u8'����� [ARZ]', imgui.ImVec2(130, 20)) then
		 show_pilot_window.v = not show_pilot_window.v
         end
		  if imgui.Button(u8"�������� [ARZ]", imgui.ImVec2(130, 20)) then
		  show_license.v = not show_license.v
		 end
         if imgui.Button(u8"�� ��������� [ALL]", imgui.ImVec2(130, 20)) then
		  show_dokumenti.v = not show_dokumenti.v
		  end
		   if imgui.Button(u8"���� [ARZ]", imgui.ImVec2(130, 20)) then
		  show_bank_menu.v = not show_bank_menu.v
		  end
		    if imgui.Button(u8"������� [RRP]", imgui.ImVec2(130, 20)) then
		  show_police_menu.v = not show_police_menu.v
		  end
		  if imgui.Button(u8"����� [RRP]", imgui.ImVec2(130, 20)) then
		  show_marry_menu.v = not show_marry_menu.v
		  end
          if imgui.Button(u8"���.��������� [RRP]", imgui.ImVec2(130, 20)) then
		  show_ap_menu.v = not show_ap_menu.v
		  end
		  if imgui.Button(u8"���� ������� [RDS]", imgui.ImVec2(130, 20)) then
		  show_report.v = not show_report.v
		  end
		  if imgui.Button(u8"����� [ALL]", imgui.ImVec2(130, 20)) then
		  show_pesni_menu.v = not show_pesni_menu.v
		  end
           if imgui.CollapsingHeader('Options') then
			if imgui.Combo(u8'���', combo_pol, arr_pol, 2) then
    if combo_pol.v == 0 then
        sampAddChatMessage("������� ���", -1)
        lady = true
    end
    if combo_pol.v == 1 then
        sampAddChatMessage("������� ���", -1)
        lady = false
    end
end
			if imgui.Checkbox(u8'������', cb_show_cursor) then
				imgui.ShowCursor = cb_show_cursor.v
			end
			
			if imgui.Checkbox(u8'����.������', cb_lock_player) then
				imgui.LockPlayer = cb_lock_player.v
			end
						if imgui.Button(u8"�������������") then
			thisScript():reload()
			sampAddChatMessage("{00D6FF}Helper ������������")
			end
			if imgui.Button(u8"���� imgui") then
            show_menu_tems.v = not show_menu_tems.v
			end
			if imgui.Button(u8"���������") then
			lua_thread.create(function ()
                imgui.Process = false
                wait(200)
				imgui.ShowCursor = false
				wait(200)
                thisScript():unload()
            end)
        end
		if imgui.Button(u8"�������") then
		show_main_window.v = false	
        end
end		

		
		  imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild("ChildWindow200778", imgui.ImVec2(590, 270), true)
		imgui.Text('asdasdasdasd')
		imgui.EndChild()

		 imgui.End()
		 
		 
		 
		 
		 
		 -- �����
		 if show_pesni_menu.v then

      imgui.Begin(u8'������� �������', show_pesni_menu)
     if imgui.Button(u8"� ����� ��������� ��������� ������") then
	 lua_thread.create(function()
	 sampSendChat("� ����� ��������� ��������� ������ � �� ����, �� ���� ��� ���� �������.")
	 wait(1500)
	 	 sampSendChat("� ����� ����� ������ � ������ � ������ ������� � ����������.")
	 end)
	 end
	 imgui.End()
	 end
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 if show_menu_tems.v then
	 imgui.Begin(u8"������� ����", show_menu_tems)
	 for i, value in ipairs(themes.colorThemes) do
                if imgui.RadioButton(value, checked_radio, i) then
                    themes.SwitchColorTheme(i) 
                end
            end
	imgui.End()
	end
	 
	 
	 
	 
	 
	 ---------- time bar
	 if show_timebar.v then
	 imgui.Text(u8"�����: "..os.date('%H:%M:%S'))
	 imgui.End()
	 
	 
	 
	 
	 
	 
	 
	 
		 -- vmf
		 if show_vmf_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Vmf Menu', show_report_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"������� ID ������", text_buffer)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"�����", text_buffer_r)
	if imgui.Button(u8"���������") then
	lua_thread.create(function()
	sampSendChat("/me ���� ����� � ����� ���-�� ������� � ���")
	   wait(1500)
		 sampSendChat(u8:decode("/r " .. text_buffer_r.v))
		 end)
		end
		imgui.SameLine()
		if imgui.Button(u8"��������") then
		text_buffer_r.v = ""
		end
		if imgui.Button(u8"OOC �����") then
		text_buffer_r.v = "//"
		end
		imgui.Text(u8"                   ����� ������������:")
		imgui.Separator()
		imgui.PushItemWidth(50)
	imgui.InputText(u8"������� �����", text_buffer_time)
		if imgui.Button(u8"������ �� �����.") then
		sampSendChat("/d [���] - [����]:��� ����� ������ �� " .. text_buffer_time.v)
		end
		imgui.Text(u8"                   �������������:")
		imgui.Separator()
		if imgui.Button(u8"������ �������������.") then
		lua_thread.create(function()
		sampSendChat("/d [���] - [����]:������� ��� �����.������� �� ����������!")
		wait(11000)
		sampSendChat("/gov [���]:������� ������� ����� ������ ������ ������.")
		wait(11000)
		sampSendChat("/gov [���]:������ ��������� ������������� � ���� ���.")
		wait(11000)
		sampSendChat("/gov [���]:����� �������� � ���������� �.���-������")
		wait(11000)
		sampSendChat("/gov [���]:��� ���� ����� �������� ���,��������,���.�����,�������.")
		wait(11000)
		sampSendChat("/gov [���]:������� �� ��������.")
		wait(5000)
		sampSendChat("/d [���] - [����]:���������� ��� �����.")
		end)
		end
	  imgui.Text(u8"                     �������� ��������:")
	  imgui.Separator()
       imgui.Columns(2, "Columnsxcssss", true)

		imgui.End()
		end
		-- helper
		 if show_helper_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(384, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(800, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin('Helper Menu', show_report_menu)
	   imgui.PushItemWidth(40)
	imgui.InputText(u8"������� ID ������ ��� ��������", text_buffer_helper_id)
	imgui.PushItemWidth(320)
	imgui.InputText(u8"������", text_buffer_helper)
	imgui.InputText(u8"������ 2", text_buffer_helper_vvod)
		imgui.Combo(u8"������", combo_report, rep_str, #rep_str, imgui.ImVec2(80, 50))
		text_buffer_helper.v = rep_str[combo_report.v + 1]
	imgui.Text(u8"������� �������: " ..text_buffer_helper.v)
	if imgui.Button(u8"��������") then
	sampSendChat(u8:decode("/pm " .. text_buffer_helper_id.v .. " " .. text_buffer_helper.v))
	end
	if imgui.Button(u8"�������� ������ 2") then
	sampSendChat(u8:decode("/pm " .. text_buffer_helper_id.v .. " " .. text_buffer_helper_vvod.v))

    end

	imgui.SameLine()
	if imgui.Button(u8"��������") then
	text_buffer_helper.v = ""
	text_buffer_helper_id.v = ""
	text_buffer_helper_vvod.v = ""
	end
	imgui.SameLine()
	if imgui.Button(u8"�������") then
	show_helper_menu.v = false
    show_main_window.v = false
	end
	imgui.End()
	end

		 -- ������
		 if show_report_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'������ Menu', show_report_menu)

	   imgui.PushItemWidth(30)
	   
	imgui.InputText(u8"������� ID ����������", text_buffer_suspeckt)
	imgui.Combo(u8"������", combo_report, rep_str, #rep_str)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"������", text_buffer_rep)
	imgui.Text(u8"������� �������: " .. text_buffer_suspeckt.v .. " " ..text_buffer_rep.v)

	if imgui.Button(u8"���������") then
		 sampSendChat(u8:decode("/report " .. text_buffer_suspeckt.v .. " " .. text_buffer_rep.v))
		end

	
		-- rep_str[combo_report.v + 1]

		imgui.End()
		end
		 -- ��
		  if show_ap_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'������������� ���������� Menu', show_police_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"������� ID ������ ��� ��������������", text_buffer)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"�����", text_buffer_r)
	if imgui.Button(u8"���������") then
		 sampSendChat(u8:decode("/r " .. text_buffer_r.v))
		end
		imgui.SameLine()
		if imgui.Button(u8"��������") then
		text_buffer_r.v = ""
		end
		if imgui.Button(u8"OOC �����") then
		text_buffer_r.v = "//"
		end
	  imgui.Text(u8"                     �������� ��������.")
	  imgui.Separator()
       imgui.Columns(2, "Columnsxcssss", true)
	    imgui.Text(u8"���������:")
		 if imgui.Button(u8"�����������.") then
		 lua_thread.create(function()
		 sampSendChat("������������, � " .. (lady and '����������' or '���������') .. " ������������� ���������� ������ ������")
		 wait(1500)
		 sampSendChat("��� ���� ��� ������?")
		 end)
		 end
		 if imgui.Button(u8"���������.") then
		 lua_thread.create(function()
		 sampSendChat("���� �� ������ ���������� � ���������� �������������, �� ��������� ������ �����.")
		 wait(1500)
		 sampSendChat("/me " .. (lady and '��������' or '�������') .. " ����� � �����" )
		 end)
		 end
		 if imgui.Button(u8"���� ���� �������.") then
		 sampSendChat("���� � ��� ���� �������, �� ��������� ��, � ���������� �������� �� ���.")
		 end
		 if imgui.Button(u8"��������� � ��.") then
		 lua_thread.create(function()
		 sampSendChat("����� ���������� �� ������, ��� ����� �������� � ����� �� �������������.")
		 wait(1500)
		 sampSendChat("/b /gps > �������� > ����� Los Santos")
		 end)
		 end
		 if imgui.Button(u8"����� �������.") then
		  lua_thread.create(function()
		 sampSendChat("����� ��� �������.")
		 wait(1500)
		 sampSendChat("/me ���������")
		 end)
		 end
		imgui.NextColumn()
		imgui.Text(u8"�������������:")
		imgui.End()
		end
		 
		 -- �����
		  if show_marry_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin('Marry Menu', show_police_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"������� ID ������ ��� ��������������", text_buffer)
	  imgui.Text(u8"                     �������� ��������.")
	  imgui.Separator()
       imgui.Columns(2, "Columnsssss", true)
	    imgui.Text(u8"�������:")
		if imgui.Button(u8"�����������.") then
		 lua_thread.create(function()
		 sampSendChat("������������, � " .. (lady and '����������' or '���������') .. " ����� ������ ������, ��� ������")
		 wait(1500)
		 sampSendChat("� ��������� ����������� ��������� �� ������������ �� ���� ����������.")
		 wait(1500)
		 sampSendChat("���� ���� ������ ���������� 50000 ����.")
		 end)
		 end
		 if imgui.Button(u8"�� ��������?") then
		 lua_thread.create(function()
		 sampSendChat("� ���, ���� �� �������� � ����� ��������� ������, ������� ��� ����� ������ ��������� �� ������")
		 wait(1500)
		 sampSendChat("/b ������ ��� id")
		 end)
		 end
		 if imgui.Button(u8"��������.") then
		 lua_thread.create(function()
		 sampSendChat("�������� ��� ��� �������.")
		 wait(1500)
		 sampSendChat("/b /showpass ��� ID ")
		 end)
		 end
		  if imgui.Button(u8"�������.") then
		 lua_thread.create(function()
		 sampSendChat(" ������� �� ������������� ����� ��������, ����� ��� �����.")
		 wait(1500)
		 sampSendChat("/me " .. (lady and '��������' or '�������') .. " ������� �������� ����� � ������� 272027")
		 wait(1500)
		 sampSendChat("/free " .. text_buffer.v .. " 50000")
		 end)
		 end
		 imgui.NextColumn()
		 imgui.Text(u8"�����:")
		  if imgui.Button(u8"������� �� ������.") then
		 lua_thread.create(function()
		 sampSendChat("/me " .. (lady and '����������' or '���������') .. " �� ���� ��������")
		 wait(1500)
		 sampSendChat("/me " .. (lady and '���������' or '��������') .. " �������� �� �����")
		 wait(1500)
		 sampSendChat("/mxpell " .. text_buffer.v .. " �.�.�����")
		 end)
		 end
	  imgui.End()
	  end
		 
		 -- Police
		 if show_police_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin('Police Menu', show_police_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"������� ID", text_buffer)
	  imgui.Text(u8"�������� ��������.")
	  imgui.Separator()
	  if imgui.Button(u8"���������.") then
	   lua_thread.create(function()
	   sampSendChat("������� �����.� " .. (lady and '����������' or '���������') .. " ��� �.��� ������.")
	   wait(1500)
	   sampSendChat("/do ������ ���������� ��� �� �����")
	   wait(1500)
	   sampSendChat("/me " .. (lady and '��������' or '�������') ..  " ������ ���������� ���")
	   wait(1500)
	    sampSendChat("/showudost " .. text_buffer.v)
	   wait(1500)
	   sampSendChat("����� ���������� �������� �������������� ���� ��������.")
	   end)
	   end
	    if imgui.Button(u8"�������.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and '��������' or '�������') ..  " ������� ����������� ����")
	   wait(1500)
	   sampSendChat("/m ��������! ���������� ���� �� � ���������� � �������!")
	   wait(1500)
	   sampSendChat("/m � ������ ������������ ����� ������ ����� �� �������!")
	   end)
	   end
	   imgui.SameLine()
	    if imgui.Button(u8"������� ����� ��� ������") then
	   sampSendChat("/m ��������� ����� �� ������ ��!")
	   end
	    if imgui.Button(u8"�������� �����.") then
	   lua_thread.create(function()
	   sampSendChat("/do �������� � ������ ����.")
	   wait(1500)
	   sampSendChat("/me " .. (lady and '����������' or '���������') .. " �������� ������ ��������" )
	   wait(1500)
	   sampSendChat("/me ��������� ������ ���������� � ��������")
	   wait(1500)
	    sampSendChat("/me " .. (lady and '��������' or '�������') .. " �������� ����������")
	   wait(1500) 
	    sampSendChat("/me " .. (lady and '��������' or '�������') .. " ��������� ����������")
		wait(1500)
		sampSetChatInputEnabled(true)
      sampSetChatInputText("/ticket " .. text_buffer.v )
	   end)
	   end
	    if imgui.Button(u8"������ ������.") then
	   lua_thread.create(function()
	   sampSendChat("/do � ���� ��������� ����-���.")
	   wait(1500)
	   sampSendChat("/me " .. (lady and '�������' or '������') .. " ����������� �� ��������� � ���� ������ ���" )
	   wait(1500)
	   sampSetChatInputEnabled(true)
      sampSetChatInputText("/su " .. text_buffer.v )
	   end)
	   end
	   if imgui.Button(u8"���.�����") then
	   lua_thread.create(function()
	   sampSendChat("/do �������-����� �� ����� ���������.")
	   wait(1500)
	   sampSendChat("/me ������ ��������� ���� " .. (lady and '�����' or '����') .. " � ����� �����")
	   wait(1500)
	   sampSendChat("/tazer 3")
	   end)
	   end
	    if imgui.Button(u8"���������") then
	   lua_thread.create(function()
	   sampSendChat("/do ��������� ����������� �� ����� ���������.")
	   wait(1500)
	   sampSendChat("/me ������ ��������� ���� " .. (lady and '�����' or '����') .. " ��������� � �����")
	   wait(1500)
	   sampSendChat("/me ���������� ����������� ���� �����������")
	   wait(1500)
	    sampSendChat("/cuff " .. text_buffer.v)
	   end)
	   end
	     if imgui.Button(u8"����� �� �����.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and '�����' or '����') .. " ����������� �� ����")
	   wait(1500)
	   sampSendChat("/me ����� ����������� �� �����")
	   wait(1500)
	   sampSendChat("/drag " .. text_buffer.v)
	   end)
	   end
	    if imgui.Button(u8"���������� �����������.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and '�������' or '������') .. " ����� �� ������")
	   wait(1500)
	   sampSendChat("/me " .. (lady and '�������' or '������') .. " ����� ������")
	   wait(1500)
	   sampSendChat("/arrest " .. text_buffer.v)
	   wait(1500)
	   sampSendChat("/me " .. (lady and '�������' or '������') .. " ����� ������")
	   wait(1500)
	   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ����� �� ������ � ������")
	   end)
	   end

	   
	   
	  
	  imgui.End()
	  end
		 

		 
		 end
    -- Yakuza
	if show_yakuza.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(20, 595), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.Begin(u8"Yakuza | Menu", show_yakuza)
	imgui.Columns(2, "Columns", true)
	imgui.Text(u8"�������� ��������")
	 imgui.PushItemWidth(30)
	imgui.InputText(u8"������� ID", text_buffer)
	imgui.Separator()
	imgui.Text(u8"������:")
	imgui.Separator()
	if imgui.Button(u8"����� �� �����") then
	 lua_thread.create(function()
	 sampSendChat("/vad ���� ����� � ����-��� ������.�������� �� ����.")
	 wait(40000)
	  sampSendChat("/vad ���� ����� � ����-��� ������.�������� �� ����.")
	  wait(2000)
	  sampAddChatMessage("{FFFFFF}������")
	  end)
	end
	if imgui.Button(u8"����� �� ������") then
	 lua_thread.create(function()
	 sampSendChat("/vad ���� ����� � ����-��� ������.�������� �� ������.")
	 wait(40000)
	  sampSendChat("/vad ���� ����� � ����-��� ������.�������� �� ������.")
	  wait(2000)
	  sampAddChatMessage("{FFFFFF}������")
	  end)
	end
	imgui.Separator()
	imgui.NextColumn()
	imgui.Text(u8"�������� �� invite:")
	imgui.Separator()
	if imgui.Button(u8"�����������") then
	sampSendChat("�������.�� � ��� �� ������ � ����-���?")
	end
	if imgui.Button(u8"���������") then
	 lua_thread.create(function()
	 sampSendChat("�������!")
	 wait(1800)
	  sampSendChat("�������� ��� ��� �������� � ��������")
	  end)
	end
	if imgui.Button(u8"������") then
	 lua_thread.create(function()
	 sampSendChat("�������� �� ������.")
	 wait(1800)
	  sampSendChat("��� � ���� ��� �������?")
	  end)
	end
	imgui.End()
	end

	
	-- Moon ImGui tutorial
	
		
		
		if show_moon_imgui_tutorial[1].v then
		imgui.Begin(u8'����������', show_moon_imgui_tutorial[1])
		imgui.Text(u8"������ ������ ������ ������� Mia Carter.")
		imgui.Text(u8"������ ��� ������ 11 ���� 2020 ����.")
		imgui.End()
	end
		
	-- ����
	if show_bank_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'���� Menu', show_bank_menu)
	  imgui.Columns(2, "Columnsss", true) 
	   imgui.PushItemWidth(30)
       imgui.InputText(u8"������� ID", text_buffer)
	  imgui.Text(u8"�������� ��������:")
	  if imgui.Button(u8"������������.") then
	  lua_thread.create(function()
	  sampSendChat("��������, �� � ������� ��� ����� ���� ��������� � �������.")
	  wait(1500)
      sampSendChat("/todo ����� � ���� ���������� ��������� ����*������ �������� �� �������� ��������")
	  end)
	  end
	   if imgui.Button(u8"����� ����������.") then
	  lua_thread.create(function()
	  sampSendChat("/me ������������ �� ���������� � �������� �������� ��� ����")
	  wait(1500)
      sampSendChat("/me ������ ������ ���������� �� ����, ������� ��� �� �����")
	  wait(1500)
	  sampSetChatInputEnabled(true)
      sampSetChatInputText("/expel " .. text_buffer.v )
	  end)
	  end
	    if imgui.Button(u8"�������� ������.") then
	  lua_thread.create(function()
	  sampSendChat("/do � ������ ������� ���� ����� ����������� ����-����� ��� �����")
	  wait(1500)
      sampSendChat("/me ������� ����� �� ������� � ������������ � �������")
	  wait(1100)
	  setVirtualKeyDown(48, true)
	  wait(200)
      setVirtualKeyDown(48, false)
	  wait(1500)
	  sampSendChat("/me ������� ����������� ����-����� ����� � ������.")
	  end)
	  end

	  -- 2 ��������
	  imgui.NextColumn()
	  imgui.Text(u8"���� ����:")
	  imgui.End()
	  end
	-- ���
	if show_report.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'������ �� ������', show_report)
	  if imgui.Button(u8"������ ������ �� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}������ �������� �� ����� ������. {FF00E6}|| �������� ���� �� Russian Drift Server!")
		end
		if imgui.Button(u8"��������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}���������� �������� ���� ������")
		end
		if imgui.Button(u8"��������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}��������. {FF00E6}|| �������� ���� �� Russian Drift Server!")
		end
		if imgui.Button(u8"�������� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}������ �������� ��� ������. {FF00E6}|| �������� ���� �� Russian Drift Server!")
		end
		if imgui.Button(u8"�����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}�����. {FF00E6}|| �������� ���� �� Russian Drift Server!")
		end
		if imgui.Button(u8"�� ��������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF0000}�� ��������! {FF00E6}|| �������� ���� �� Russian Drift Server! ")
		end
		if imgui.Button(u8"��������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}��������, �������� �������� �����")
		end
		if imgui.Button(u8"�������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�������� ���� �� Russian Drift Server!")
		end
		imgui.Separator()
		  if imgui.CollapsingHeader(u8'������ �� �������') then
		  if imgui.CollapsingHeader(u8'��� ���') then
		   if imgui.Button(u8"��� ����� ������� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}� ��� �� /trade �� 10.000 �����")
			end
			 if imgui.Button(u8"��� ����� ������� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}� ��� �� /trade �� 10.000 �����")
			end
			if imgui.Button(u8"��� ����� ������� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/donate > 4 �����")
			end
			if imgui.Button(u8"��� ����� �������� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/donate > 5 �����")
			end
			if imgui.Button(u8"��� ����� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}������ ���������� ������� � /help > 7 {FF00E6}�������� ���� �� Russian Drift Server!")
			end
			end
			imgui.Separator()
		  if imgui.CollapsingHeader(u8'��� ����� ���� � ������') then
	if imgui.Button(u8"��� ���������� ������, ����� � ����") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}��� ��������� �� ������ ������ � /help > 13")
			end
			if imgui.Button(u8"���� ������� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� ������ ����, �����, ��������� � �.�")
			end
			if imgui.Button(u8"���� ������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� ������ ����, ���������, ��� �������, �������� � �.�")
			end
			if imgui.Button(u8"���� ������� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� ������ ������� ��������, ������ � �.�")
			end
			if imgui.Button(u8"��� �������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/givescore ��� ������� ������� ���")
			end
			if imgui.Button(u8"��� �������� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}� ��������� �����. {FF00E6}|| �������� ���� �� Russian Drift Server!")
			end
			if imgui.Button(u8"��� �������� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}/givemoney id ����� {FF00E6}|| �������� ���� �� Russian Drift Server!")
			end
			if imgui.Button(u8"��� �������� ���� �� ����� ��� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}� ������ �� /trade {FF00E6}|| �������� ���� �� Russian Drift Server!")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'��� �����') then
			 if imgui.Button(u8"��� ������� � �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ������� ���� > ���������� � �����")
			end
			if imgui.Button(u8"��� ����� �� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/gleave || �������� ���� �� Russian Drift Server!")
			end
			if imgui.Button(u8"������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ������ ����.��� �� ��� �������")
			end
			if imgui.Button(u8"��� �������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ������ ���� > �������")
			end
			 if imgui.Button(u8"�����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}���������� � ���������. ������ - https://basicweb.ru/html/html_colors.php")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'�����') then
			 if imgui.Button(u8"��� ������� � �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/finvite. {FF0000}�������� ����")
			end
			if imgui.Button(u8"��� �������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/trade > � ��� ������ �� 50.000 �����")
			end
			 if imgui.Button(u8"��� ���� �� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/familypanel > �������� �����")
			end
			 if imgui.Button("familypanel") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/familypanel, ��� �� ������� ��� �����")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'������') then
			if imgui.Button(u8"������ �� ����������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}������ �� �� ���������� > vk.com/id139345872")
			end
			if imgui.Button(u8"������ �� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}����� � �� > vk.com/vipgamer228")
			end
			if imgui.Button(u8"������ ������ �������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}������ � �� > vk.com/dmdriftgta")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'���') then
			if imgui.Button(u8"��� ������ ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}����� ���������, ����� �� �����, ������ F > ������")
			end
			if imgui.Button(u8"��� ������� ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}� ��� - /hpanel > ������� ���.������� ��� ������ /sellmyhouse id ����")
			end
			if imgui.Button(u8"��� ��������� � ���") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/hpanel > ������ ������� > ���������")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'���������') then
			if imgui.Button(u8"��� ����� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > ��� ����������")
			end
			if imgui.Button(u8"��� �������������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > ������")
			end
			if imgui.Button(u8"��� ���������� �/� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/car > ����������")
			end
			if imgui.Button(u8"��� ������ ������ ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/tp > ������ > ����������")
			end
			if imgui.Button(u8"��� ������� �/� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}� ��� - /car > ������� ����.������� ������ - /autoyartp")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'������') then
			if imgui.Button(u8"��� ����� ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ������")
			end
			if imgui.Button(u8"��� ������ ������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ������ > ������ ������")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'����� ���������') then
			if imgui.Button(u8"����/����� �������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 1 �����")
			end
			if imgui.Button(u8"���������� �������� �� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 2 �����")
			end
			if imgui.Button(u8"���/���� ������ ���������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 3 �����")
			end
			if imgui.Button(u8"������� �� ��������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 4 �����")
			end
			if imgui.Button(u8"����� DM ����������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 5 �����")
			end
			if imgui.Button(u8"����� ��� ������������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 6 �����")
			end
			if imgui.Button(u8"���������� ���������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 7 �����")
			end
			if imgui.Button(u8"���������� ����� �������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 8 �����")
			end
			if imgui.Button(u8"����� � ����/���� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 9 �����")
			end
			if imgui.Button(u8"����� �������� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 10 �����")
			end
			if imgui.Button(u8"���/���� ����������� � �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 11 �����")
			end
			if imgui.Button(u8"����� �� �� ����� �����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 12 �����")
			end
			if imgui.Button(u8"���/���� ����") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 13 �����")
			end
			if imgui.Button(u8"���/���� ��� ����������") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 15 �����")
			end
			end
		  if imgui.CollapsingHeader(u8'������') then
	if imgui.Button(u8"������ ������") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}������ ������ � ������ �� > vk.com/dmdriftgta")
			end
			if imgui.Button(u8"���������� � ���������.") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}���������� � ���������")
			end
			if imgui.Button(u8"���") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}���.�������� ����")
			end
			if imgui.Button(u8"�� ������") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� ������.")
			end
			if imgui.Button(u8"�� ����������") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� ����������")
			end
			if imgui.Button(u8"��� ����� ����") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�� �������� ��� ������� 100 ��������� �� �����")
			end
			if imgui.Button(u8"��� ���/���� ����") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ��������� > 13 �����")
			end
			if imgui.Button(u8"��� ���������� �����") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/duel id.�������� ����")
			end
			if imgui.Button(u8"�����������") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}��������� ��������� �� ������")
			end
			if imgui.Button(u8"�����") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}�����.�������� ����")
			end
			end
			end
			imgui.End()
			end

  -- Pilot Window
  
  if show_pilot_window.v then
  imgui.SetNextWindowPos(imgui.ImVec2(10, 320), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
  imgui.Begin(u8'������ ������', show_pilot_window, imgui.WindowFlags.NoMove)
  imgui.Text(u8"��� ������������ ���� ������.")
  imgui.Text(u8"�������� ������ ������� ��������� ����")
  imgui.Separator()
  if imgui.Button(u8"������ �����") then
		show_pilot_puti.v = not show_pilot_puti.v
		end
		imgui.SameLine()
  if imgui.Button(u8"����������������") then
  lua_thread.create(function()
  sampSendChat("/pt ������ ���� �������.")
  wait(5200)
  sampSendChat("/pt ��� ���� ����?")
  wait(5200)
  sampSendChat("/pt ��� ������?")
  end)
  end
  if imgui.Button(u8"�������") then
  lua_thread.create(function()
  sampSendChat("/pt ��������� ��� ��� � ��� ���� ���� ������� ������.")
  wait(5200)
  sampSendChat("/pt � ��� ����� ��� ������.")
  wait(5200)
  sampSendChat("/pt ����������� � ��� :)  - https://discord.gg/Hgmzkj")
  wait(600000)
  sampSendChat("/pt ��������� ��� ��� � ��� ���� ���� ������� ������.")
  wait(5200)
  sampSendChat("/pt � ��� ����� ��� ������.")
  wait(5200)
  sampSendChat("/pt ����������� � ��� :)  - https://discord.gg/Hgmzkj")
  wait(1061)
  sampAddChatMessage("{FF00E6}��������� ����������!")
  end)
  end
		imgui.End()
		end






  if show_pilot_puti.v then
  imgui.SetNextWindowPos(imgui.ImVec2(720, 410), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.Begin(u8'������ �����', show_pilot_puti, imgui.WindowFlags.NoMove)
   imgui.Text(u8"�������� ���� �� �������� �� ������ ������.")
   imgui.Separator()
   if imgui.Button(u8'��� ������ -> ��� �����') then
        lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� ������ -> ��� �����")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	if imgui.Button(u8'��� ������ -> ��� ��������') then
	lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� ������ -> ��� ��������")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	if imgui.Button(u8'��� ����� -> ��� ������') then
	lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� ����� -> ��� ������")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	if imgui.Button (u8'��� ����� -> ��� ��������') then
	lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� ����� -> ��� ��������")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	if imgui.Button(u8'��� �������� -> ��� ������') then
	lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� �������� -> ��� ������")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	if imgui.Button(u8'��� �������� -> ��� �����') then
	lua_thread.create(function()
		sampSendChat("/pt ���� �461 ����� � ������.")
		wait(5200)
		sampSendChat("/pt ���� - ��� �������� -> ��� �����")
		wait(5200)
		sampSendChat("/pt ����� ���������� ������ ��� ������!")
		end)
	end
	imgui.End()
	end
   
   -- ���������
   if show_dokumenti.v then
   imgui.SetNextWindowPos(imgui.ImVec2(10, 510), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.Begin(u8"�� ���������", show_dokumenti, imgui.WindowFlags.NoMove)
   imgui.PushItemWidth(30)
   imgui.InputText(u8"������� ID ������.", text_buffer)
   if imgui.Button(u8"�������") then
   lua_thread.create(function()
   sampSendChat("/do � ������� � " .. nick .. " ��������� �������.")
   wait(2000)
   sampSendChat("/me " .. (lady and '������' or '�����') .. " ���� � ������")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " �������")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ������� �� �������")
   wait(2000)
   sampSendChat("/do ������� � ����.")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ������� �������� �� ������")
   wait(2000)
   sampSendChat("/showpass " .. text_buffer.v)
   end)
   end
   imgui.SameLine()
    if imgui.Button(u8"��������") then
   lua_thread.create(function()
   sampSendChat("/do � ����� � " .. nick .. " ��������� ��������")
   wait(2000)
   sampSendChat("/me " .. (lady and '�������' or '������') .. " �����")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ��� ��������")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " �������� �� �����")
   wait(2000)
   sampSendChat("/do �������� � ����.")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " �������� �������� �� ������")
   wait(2000)
  sampSendChat("/showlic " .. text_buffer.v)
   end)
   end
    imgui.SameLine()
    if imgui.Button(u8"���.�����") then
   lua_thread.create(function()
   sampSendChat("/do � ������� � " .. nick .. " ��������� ���.�����")
   wait(2000)
   sampSendChat("/me " .. (lady and '������' or '�����') .. " ���� � ������")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ���.�����")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ���.����� �� �������")
   wait(2000)
   sampSendChat("/do ���.����� � ����.")
   wait(2000)
   sampSendChat("/me " .. (lady and '��������' or '�������') .. " ���.����� �������� �� ������")
   wait(2000)
  sampSendChat("/showmc " .. text_buffer.v)
   end)
   end
   
   imgui.End()
   end
   
   
   -- license
   
  if show_license.v then
  imgui.Begin('License', show_license)
		imgui.Text(u8'�������� ��������')
		imgui.PushItemWidth(30)
		 imgui.InputText(u8"������� ID ������.", text_buffer)
		imgui.Separator()
		imgui.Text(u8'����������:')
		imgui.Separator()
		if imgui.Button(u8"����������������") then
		lua_thread.create(function()
		sampSendChat('������������, ���� ����� ��� ������, ��� ���� ��� ������?')
		wait(1200)
		sampSendChat('/do �� ����� ����� ������� � ��������: ����������� ��, ��� ������.')
		end)
		end
		if imgui.Button(u8"����� ����") then
		lua_thread.create(function()
		sampSendChat('/do � ���� ��������� �����-����.')
		wait(1200)
		sampSendChat('/me �������� ����� ���� �������')
		wait(1200)
		sampSendChat('/do �� ����� ����� ���������:')
		wait(1200)
		sampSendChat('/do �������� �� ���� - 2.200$')
		wait(1200)
		sampSendChat('/do �������� �� ���� - 5.000$')
		wait(1200)
		sampSendChat('/do �������� �� ����������� - 10.000$')
		wait(1200)
		sampSendChat('/do �������� �� �������� ������ �/� - 25.000$')
		wait(1200)
		sampSendChat('/do �������� �� ������ - 20.000$')
		wait(1200)
		sampSendChat('/do �������� �� ����� - 200.000$')
		wait(1200)
		sampSendChat('/do �������� �� ������ - ����� �������� � ���������')
		end)
		end
		imgui.Separator()
		imgui.Text(u8'��������:')
		imgui.Separator()
		if imgui.Button(u8"������ ��������") then
		lua_thread.create(function()
		sampSendChat('/todo ������, ��������� *�������� ��� � ���� ������� � ���-�� ������� �� ���')
		wait(2200)
		sampSendChat('/do �� ��� ������� ������ ��������, � �������� ��������������� ����.')
		wait(2200)
		sampSendChat('/me ������������ ����� ��������')
		wait(2200)
		sampSendChat('/do ��� �������� ���.')
		wait(2200)
		sampSendChat('/do ��� �����.')
		wait(2200)
		sampSendChat('/do �� ���� �������� ����� ������.')
		wait(2200)
		sampSendChat("/me " .. (lady and '��������' or '�������') .. " ��� �������� �� ������")
		wait(2200)
		sampSendChat("/me " .. (lady and '�����' or '����') .. " ������ ���������� � ���")
		wait(2200)
		sampSendChat('/do ������ ������� �����.')
		wait(2200)
		sampSendChat("/givelicense " .. text_buffer.v)
		wait(2000)
		sampSendChat('��� ���� ��������, ����� ��� ��������!')
		end)
		end
		if imgui.Button(u8"��������� ���.�����") then
		lua_thread.create(function()
		sampSendChat('��� ������� �������� �� ������ ���������� ���������� ���� ���.�����')
		wait(1200)
		sampSendChat('/b ���-�� �������� ���.����� ������� /showmc ')
		end)
		end
		imgui.End()
		end

	-- Standard ImGui
if show_imgui_example.v then
		imgui.Begin('ImGui example', show_imgui_example)
		imgui.Text('Hello, world!')
		imgui.SliderFloat('float', slider_float, 0.0, 12.0)
		imgui.ColorEdit3(u8'�����', clear_color)
		if imgui.Button('Another Window') then
			show_another_window.v = not show_another_window.v
		end
		local framerate = imgui.GetIO().Framerate
		imgui.Text(string.format('Application average %.3f ms/frame (%.1f FPS)', 2000.0 / framerate, framerate))
		imgui.End()
	end

	if show_another_window.v then
		imgui.Begin('Another Window', show_another_window)
		imgui.Text('Hello from another window!')
		imgui.End()
	end

	if show_test_window.v then
		imgui.SetNextWindowPos(imgui.ImVec2(620, 20), imgui.Cond.FirstUseEver)
		imgui.ShowTestWindow(show_test_window)
	end
end

end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	dialogID = dialogid
end

function main()
    
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
while not isSampAvailable() do wait(100) end


    thread = lua_thread.create_suspended(thread_function)

    imgui.SwitchContext()
	themes.SwitchColorTheme(3)


   sampRegisterChatCommand("dadaya", cmd_dadaya)
    sampRegisterChatCommand("update", cmd_update)

     _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nick = sampGetPlayerNickname(id)
	

	


     sampAddChatMessage("{FF0000}[Dadaya Helper] {FFFFFF}��������!")
	 

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


		 
		
           
	    
		imgui.Process = show_main_window.v

	end

imgui.End()
end

function cmd_dadaya(arg)
	show_main_window.v = not show_main_window.v
	imgui.Process = show_main_window.v
end

function cmd_update(arg)
    sampShowDialog(1000, "�������������� v2.0", "{FFFFFF}��� ���� �� ����������\n{FFF000}����� ������", "�������", "", 0)
end