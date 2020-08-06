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

local update_url = "https://raw.githubusercontent.com/CatMav228/Scripts/master/Update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "" -- тут свою ссылку
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
 -- Документы
 local show_dokumenti = imgui.ImBool(false)
 -- Лицензер
 local show_license = imgui.ImBool(false)
 -- Антибиотики
 local check_antibiotiki = imgui.ImBool(false)
 -- Рдс
 local show_report = imgui.ImBool(false)
 local show_yakuza = imgui.ImBool(false)
-- Анимации
local show_anims = imgui.ImBool(false)
-- Банк
local show_bank_menu = imgui.ImBool(false)
-- Полиция
local show_police_menu = imgui.ImBool(false)
-- Мэрия
local show_marry_menu = imgui.ImBool(false)
-- АП
local show_ap_menu = imgui.ImBool(false)
local show_report_menu = imgui.ImBool(false)
-- ВМФ
local show_vmf_menu = imgui.ImBool(false)
-- Песни
local show_pesni_menu = imgui.ImBool(false)
local show_menu_tems = imgui.ImBool(false)
--------------------------------------------
local show_timebar = imgui.ImBool(false)
function imgui.OnDrawFrame()
local arr_pol = {u8"Женский", u8"Мужской"}
-- imgui.NextColumn()
	-- Main Window
	if show_main_window.v then
		local sw, sh = getScreenResolution()

		-- center END key
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.3, sh / 1.3), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(750, 300), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' Панель Функций', show_main_window)
		local framerate = imgui.GetIO().Framerate
		local btn_size = imgui.ImVec2(-0.1, 0)
		
	     imgui.BeginChild("ChildWindow2007", imgui.ImVec2(140, 270), true)
		
		
		if imgui.Button('EXM Panel', imgui.ImVec2(130, 20)) then
			show_imgui_example.v = not show_imgui_example.v
		end


         if imgui.Button(u8'Пилот [ARZ]', imgui.ImVec2(130, 20)) then
		 show_pilot_window.v = not show_pilot_window.v
         end
		  if imgui.Button(u8"Лицензер [ARZ]", imgui.ImVec2(130, 20)) then
		  show_license.v = not show_license.v
		 end
         if imgui.Button(u8"Рп документы [ALL]", imgui.ImVec2(130, 20)) then
		  show_dokumenti.v = not show_dokumenti.v
		  end
		   if imgui.Button(u8"Банк [ARZ]", imgui.ImVec2(130, 20)) then
		  show_bank_menu.v = not show_bank_menu.v
		  end
		    if imgui.Button(u8"Полиция [RRP]", imgui.ImVec2(130, 20)) then
		  show_police_menu.v = not show_police_menu.v
		  end
		  if imgui.Button(u8"Мэрия [RRP]", imgui.ImVec2(130, 20)) then
		  show_marry_menu.v = not show_marry_menu.v
		  end
          if imgui.Button(u8"Адм.Президент [RRP]", imgui.ImVec2(130, 20)) then
		  show_ap_menu.v = not show_ap_menu.v
		  end
		  if imgui.Button(u8"Меню Репорта [RDS]", imgui.ImVec2(130, 20)) then
		  show_report.v = not show_report.v
		  end
		  if imgui.Button(u8"Песни [ALL]", imgui.ImVec2(130, 20)) then
		  show_pesni_menu.v = not show_pesni_menu.v
		  end
           if imgui.CollapsingHeader('Options') then
			if imgui.Combo(u8'Пол', combo_pol, arr_pol, 2) then
    if combo_pol.v == 0 then
        sampAddChatMessage("Женский пол", -1)
        lady = true
    end
    if combo_pol.v == 1 then
        sampAddChatMessage("Мужской пол", -1)
        lady = false
    end
end
			if imgui.Checkbox(u8'Курсор', cb_show_cursor) then
				imgui.ShowCursor = cb_show_cursor.v
			end
			
			if imgui.Checkbox(u8'Забл.Игрока', cb_lock_player) then
				imgui.LockPlayer = cb_lock_player.v
			end
						if imgui.Button(u8"Перезагрузить") then
			thisScript():reload()
			sampAddChatMessage("{00D6FF}Helper перезагружен")
			end
			if imgui.Button(u8"Тема imgui") then
            show_menu_tems.v = not show_menu_tems.v
			end
			if imgui.Button(u8"Выключить") then
			lua_thread.create(function ()
                imgui.Process = false
                wait(200)
				imgui.ShowCursor = false
				wait(200)
                thisScript():unload()
            end)
        end
		if imgui.Button(u8"Закрыть") then
		show_main_window.v = false	
        end
end		

		
		  imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild("ChildWindow200778", imgui.ImVec2(590, 270), true)
		imgui.Text('asdasdasdasd')
		imgui.EndChild()

		 imgui.End()
		 
		 
		 
		 
		 
		 -- Песни
		 if show_pesni_menu.v then

      imgui.Begin(u8'Веселые песенки', show_pesni_menu)
     if imgui.Button(u8"Я еблан занимаюсь постоянно хуйней") then
	 lua_thread.create(function()
	 sampSendChat("Я еблан занимаюсь постоянно хуйней я не знал, об этом мне люди сказали.")
	 wait(1500)
	 	 sampSendChat("Я еблан люблю играть в сампец и ночами залипаю в майнкрафте.")
	 end)
	 end
	 imgui.End()
	 end
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 if show_menu_tems.v then
	 imgui.Begin(u8"Сменить тему", show_menu_tems)
	 for i, value in ipairs(themes.colorThemes) do
                if imgui.RadioButton(value, checked_radio, i) then
                    themes.SwitchColorTheme(i) 
                end
            end
	imgui.End()
	end
	 
	 
	 
	 
	 
	 ---------- time bar
	 if show_timebar.v then
	 imgui.Text(u8"Время: "..os.date('%H:%M:%S'))
	 imgui.End()
	 
	 
	 
	 
	 
	 
	 
	 
		 -- vmf
		 if show_vmf_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Vmf Menu', show_report_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"Введите ID игрока", text_buffer)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"Рация", text_buffer_r)
	if imgui.Button(u8"Отправить") then
	lua_thread.create(function()
	sampSendChat("/me сняв рацию с пояса что-то сказала в нее")
	   wait(1500)
		 sampSendChat(u8:decode("/r " .. text_buffer_r.v))
		 end)
		end
		imgui.SameLine()
		if imgui.Button(u8"Очистить") then
		text_buffer_r.v = ""
		end
		if imgui.Button(u8"OOC рация") then
		text_buffer_r.v = "//"
		end
		imgui.Text(u8"                   Рация Депортамента:")
		imgui.Separator()
		imgui.PushItemWidth(50)
	imgui.InputText(u8"Введите время", text_buffer_time)
		if imgui.Button(u8"Занята ли волна.") then
		sampSendChat("/d [ВМФ] - [Всем]:Гос волна занята на " .. text_buffer_time.v)
		end
		imgui.Text(u8"                   Собеседование:")
		imgui.Separator()
		if imgui.Button(u8"Начать собеседование.") then
		lua_thread.create(function()
		sampSendChat("/d [ВМФ] - [Всем]:Занимаю Гос Волну.Просьба не перебивать!")
		wait(11000)
		sampSendChat("/gov [ВМФ]:Доброго времени суток жители города Москва.")
		wait(11000)
		sampSendChat("/gov [ВМФ]:Сейчас состоится собеседование в ряды ВМФ.")
		wait(11000)
		sampSendChat("/gov [ВМФ]:Набор проходит в военкомате г.Лос-Сантос")
		wait(11000)
		sampSendChat("/gov [ВМФ]:При себе иметь опрятный вид,лицензии,мед.карту,паспорт.")
		wait(11000)
		sampSendChat("/gov [ВМФ]:Спасибо за внимание.")
		wait(5000)
		sampSendChat("/d [ВМФ] - [Всем]:Освобождаю Гос Волну.")
		end)
		end
	  imgui.Text(u8"                     Выбирете действие:")
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
	imgui.InputText(u8"Введите ID игрока для отправки", text_buffer_helper_id)
	imgui.PushItemWidth(320)
	imgui.InputText(u8"Репорт", text_buffer_helper)
	imgui.InputText(u8"Репорт 2", text_buffer_helper_vvod)
		imgui.Combo(u8"Ответы", combo_report, rep_str, #rep_str, imgui.ImVec2(80, 50))
		text_buffer_helper.v = rep_str[combo_report.v + 1]
	imgui.Text(u8"Образец репорта: " ..text_buffer_helper.v)
	if imgui.Button(u8"Ответить") then
	sampSendChat(u8:decode("/pm " .. text_buffer_helper_id.v .. " " .. text_buffer_helper.v))
	end
	if imgui.Button(u8"Ответить репорт 2") then
	sampSendChat(u8:decode("/pm " .. text_buffer_helper_id.v .. " " .. text_buffer_helper_vvod.v))

    end

	imgui.SameLine()
	if imgui.Button(u8"Очистить") then
	text_buffer_helper.v = ""
	text_buffer_helper_id.v = ""
	text_buffer_helper_vvod.v = ""
	end
	imgui.SameLine()
	if imgui.Button(u8"Закрыть") then
	show_helper_menu.v = false
    show_main_window.v = false
	end
	imgui.End()
	end

		 -- Репорт
		 if show_report_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Репорт Menu', show_report_menu)

	   imgui.PushItemWidth(30)
	   
	imgui.InputText(u8"Введите ID нарушителя", text_buffer_suspeckt)
	imgui.Combo(u8"Ответы", combo_report, rep_str, #rep_str)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"Репорт", text_buffer_rep)
	imgui.Text(u8"Образец репорта: " .. text_buffer_suspeckt.v .. " " ..text_buffer_rep.v)

	if imgui.Button(u8"Отправить") then
		 sampSendChat(u8:decode("/report " .. text_buffer_suspeckt.v .. " " .. text_buffer_rep.v))
		end

	
		-- rep_str[combo_report.v + 1]

		imgui.End()
		end
		 -- Ап
		  if show_ap_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Администрация Президента Menu', show_police_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"Введите ID игрока для взаимодействия", text_buffer)
	imgui.PushItemWidth(200)
	imgui.InputText(u8"Рация", text_buffer_r)
	if imgui.Button(u8"Отправить") then
		 sampSendChat(u8:decode("/r " .. text_buffer_r.v))
		end
		imgui.SameLine()
		if imgui.Button(u8"Очистить") then
		text_buffer_r.v = ""
		end
		if imgui.Button(u8"OOC рация") then
		text_buffer_r.v = "//"
		end
	  imgui.Text(u8"                     Выбирете действие.")
	  imgui.Separator()
       imgui.Columns(2, "Columnsxcssss", true)
	    imgui.Text(u8"Секретарь:")
		 if imgui.Button(u8"Приветствие.") then
		 lua_thread.create(function()
		 sampSendChat("Здравствуйте, я " .. (lady and 'сотрудница' or 'сотрудник') .. " Администрации Президента Города Москва")
		 wait(1500)
		 sampSendChat("Чем могу вам помочь?")
		 end)
		 end
		 if imgui.Button(u8"Обратится.") then
		 lua_thread.create(function()
		 sampSendChat("Если вы хотите обратиться к сотруднику Администрации, то заполните данный бланк.")
		 wait(1500)
		 sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " бланк и ручку" )
		 end)
		 end
		 if imgui.Button(u8"Если есть вопросы.") then
		 sampSendChat("Если у Вас есть вопросы, то задавайте их, я постараюсь ответить на них.")
		 end
		 if imgui.Button(u8"Устроится в АП.") then
		 lua_thread.create(function()
		 sampSendChat("Чтобы устроиться на работу, вам нужно приехать в мерию на собеседование.")
		 wait(1500)
		 sampSendChat("/b /gps > Основные > Мэрия Los Santos")
		 end)
		 end
		 if imgui.Button(u8"Всего доброго.") then
		  lua_thread.create(function()
		 sampSendChat("Всего Вам доброго.")
		 wait(1500)
		 sampSendChat("/me улыбается")
		 end)
		 end
		imgui.NextColumn()
		imgui.Text(u8"Администрация:")
		imgui.End()
		end
		 
		 -- Мэрия
		  if show_marry_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin('Marry Menu', show_police_menu)
	   imgui.PushItemWidth(30)
	imgui.InputText(u8"Введите ID игрока для взаимодействия", text_buffer)
	  imgui.Text(u8"                     Выбирете действие.")
	  imgui.Separator()
       imgui.Columns(2, "Columnsssss", true)
	    imgui.Text(u8"Адвокат:")
		if imgui.Button(u8"Приветствие.") then
		 lua_thread.create(function()
		 sampSendChat("Здравствуйте, я " .. (lady and 'сотрудница' or 'сотрудник') .. " Мэрии Города Москва, Миа Картер")
		 wait(1500)
		 sampSendChat("Я занимаюсь Юридической практикой по освобождению из мест заключения.")
		 wait(1500)
		 sampSendChat("Цена моей помощи составляет 50000 вирт.")
		 end)
		 end
		 if imgui.Button(u8"Вы согласны?") then
		 lua_thread.create(function()
		 sampSendChat("И так, если Вы согласны с моими условиями помощи, скажите мне номер вашего протокола об аресте")
		 wait(1500)
		 sampSendChat("/b Точнее Ваш id")
		 end)
		 end
		 if imgui.Button(u8"Докумены.") then
		 lua_thread.create(function()
		 sampSendChat("Покажите мне Ваш паспорт.")
		 wait(1500)
		 sampSendChat("/b /showpass мой ID ")
		 end)
		 end
		  if imgui.Button(u8"Визитка.") then
		 lua_thread.create(function()
		 sampSendChat(" Спасибо за использование моими услугами, желаю Вам удачи.")
		 wait(1500)
		 sampSendChat("/me " .. (lady and 'показала' or 'показал') .. " визитку Адвоката Мэрии с номером 272027")
		 wait(1500)
		 sampSendChat("/free " .. text_buffer.v .. " 50000")
		 end)
		 end
		 imgui.NextColumn()
		 imgui.Text(u8"Мэрия:")
		  if imgui.Button(u8"Выгнать из здания.") then
		 lua_thread.create(function()
		 sampSendChat("/me " .. (lady and 'схватилась' or 'схватился') .. " за руки человека")
		 wait(1500)
		 sampSendChat("/me " .. (lady and 'выстовила' or 'выстовил') .. " человека за дверь")
		 wait(1500)
		 sampSendChat("/mxpell " .. text_buffer.v .. " Н.П.Мэрии")
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
	imgui.InputText(u8"Введите ID", text_buffer)
	  imgui.Text(u8"Выбирете действие.")
	  imgui.Separator()
	  if imgui.Button(u8"Документы.") then
	   lua_thread.create(function()
	   sampSendChat("Здравия желаю.Я " .. (lady and 'сотрудница' or 'сотрудник') .. " ДПС г.Лос Сантос.")
	   wait(1500)
	   sampSendChat("/do Значок сотрудника ДПС на груди")
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'показала' or 'показал') ..  " значок сотрудника ДПС")
	   wait(1500)
	    sampSendChat("/showudost " .. text_buffer.v)
	   wait(1500)
	   sampSendChat("Прошу предъявить документ удостоверяющий вашу личность.")
	   end)
	   end
	    if imgui.Button(u8"Мегафон.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and 'включила' or 'включил') ..  " мегафон патрульного авто")
	   wait(1500)
	   sampSendChat("/m Водитель! Остановите ваше ТС и прижмитесь к обочине!")
	   wait(1500)
	   sampSendChat("/m В случае неподченения будет открыт огонь по колесам!")
	   end)
	   end
	   imgui.SameLine()
	    if imgui.Button(u8"Открыть огонь при погоне") then
	   sampSendChat("/m Открываем огонь по вашему ТС!")
	   end
	    if imgui.Button(u8"Выписать штраф.") then
	   lua_thread.create(function()
	   sampSendChat("/do Протокол в правой руке.")
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'развернула' or 'развернул') .. " протокол чистой стороной" )
	   wait(1500)
	   sampSendChat("/me вписывает данные нарушителя в протокол")
	   wait(1500)
	    sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " протокол нарушителю")
	   wait(1500) 
	    sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " квитанцию нарушителю")
		wait(1500)
		sampSetChatInputEnabled(true)
      sampSetChatInputText("/ticket " .. text_buffer.v )
	   end)
	   end
	    if imgui.Button(u8"Выдать розыск.") then
	   lua_thread.create(function()
	   sampSendChat("/do В руке находится Мини-КПК.")
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'пробила' or 'пробил') .. " преступника по внешности в базе данных МВД" )
	   wait(1500)
	   sampSetChatInputEnabled(true)
      sampSetChatInputText("/su " .. text_buffer.v )
	   end)
	   end
	   if imgui.Button(u8"Исп.Тазер") then
	   lua_thread.create(function()
	   sampSendChat("/do Электро-шокер на поясе крепления.")
	   wait(1500)
	   sampSendChat("/me легким движением руки " .. (lady and 'сняла' or 'снял') .. " с пояса тазер")
	   wait(1500)
	   sampSendChat("/tazer 3")
	   end)
	   end
	    if imgui.Button(u8"Наручники") then
	   lua_thread.create(function()
	   sampSendChat("/do Наручники закрепленны на поясе крепления.")
	   wait(1500)
	   sampSendChat("/me легким движением руки " .. (lady and 'сняла' or 'снял') .. " наручники с пояса")
	   wait(1500)
	   sampSendChat("/me закрепляет наручниками руки преступника")
	   wait(1500)
	    sampSendChat("/cuff " .. text_buffer.v)
	   end)
	   end
	     if imgui.Button(u8"Вести за собой.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and 'взяла' or 'взял') .. " преступника за руку")
	   wait(1500)
	   sampSendChat("/me ведет преступника за собой")
	   wait(1500)
	   sampSendChat("/drag " .. text_buffer.v)
	   end)
	   end
	    if imgui.Button(u8"Арестовать преступника.") then
	   lua_thread.create(function()
	   sampSendChat("/me " .. (lady and 'достала' or 'достал') .. " ключи от тюрьмы")
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'открыла' or 'открыл') .. " дверь тюрьмы")
	   wait(1500)
	   sampSendChat("/arrest " .. text_buffer.v)
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'закрыла' or 'закрыл') .. " дверь тюрьмы")
	   wait(1500)
	   sampSendChat("/me " .. (lady and 'положила' or 'положил') .. " ключи от тюрьмы в карман")
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
	imgui.Text(u8"Выбирете действие")
	 imgui.PushItemWidth(30)
	imgui.InputText(u8"Введите ID", text_buffer)
	imgui.Separator()
	imgui.Text(u8"Наборы:")
	imgui.Separator()
	if imgui.Button(u8"Набор на маяке") then
	 lua_thread.create(function()
	 sampSendChat("/vad Идет набор в Суши-Бар Якудза.Желающие на маяк.")
	 wait(40000)
	  sampSendChat("/vad Идет набор в Суши-Бар Якудза.Желающие на маяк.")
	  wait(2000)
	  sampAddChatMessage("{FFFFFF}Готово")
	  end)
	end
	if imgui.Button(u8"Набор на колесе") then
	 lua_thread.create(function()
	 sampSendChat("/vad Идет набор в Суши-Бар Якудза.Желающие на колесо.")
	 wait(40000)
	  sampSendChat("/vad Идет набор в Суши-Бар Якудза.Желающие на колесо.")
	  wait(2000)
	  sampAddChatMessage("{FFFFFF}Готово")
	  end)
	end
	imgui.Separator()
	imgui.NextColumn()
	imgui.Text(u8"Проверка на invite:")
	imgui.Separator()
	if imgui.Button(u8"Приветствие") then
	sampSendChat("Конишуа.Вы к нам на работу в Суши-Бар?")
	end
	if imgui.Button(u8"Документы") then
	 lua_thread.create(function()
	 sampSendChat("Отлично!")
	 wait(1800)
	  sampSendChat("Покажите мне ваш пасспорт и лицензии")
	  end)
	end
	if imgui.Button(u8"Голова") then
	 lua_thread.create(function()
	 sampSendChat("Ответьте на вопрос.")
	 wait(1800)
	  sampSendChat("Что у меня над головой?")
	  end)
	end
	imgui.End()
	end

	
	-- Moon ImGui tutorial
	
		
		
		if show_moon_imgui_tutorial[1].v then
		imgui.Begin(u8'Информация', show_moon_imgui_tutorial[1])
		imgui.Text(u8"Данный скрипт создан игроком Mia Carter.")
		imgui.Text(u8"Скрипт был создан 11 Июня 2020 года.")
		imgui.End()
	end
		
	-- Банк
	if show_bank_menu.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Банк Menu', show_bank_menu)
	  imgui.Columns(2, "Columnsss", true) 
	   imgui.PushItemWidth(30)
       imgui.InputText(u8"Введите ID", text_buffer)
	  imgui.Text(u8"Выберите дейсвтие:")
	  if imgui.Button(u8"Предупредить.") then
	  lua_thread.create(function()
	  sampSendChat("Простите, но я попрошу вас вести себя адекватно и вежливо.")
	  wait(1500)
      sampSendChat("/todo Иначе я буду вынужденна применить силу*грозно взглянув на человека напротив")
	  end)
	  end
	   if imgui.Button(u8"Вывод нарушителя.") then
	  lua_thread.create(function()
	  sampSendChat("/me накидывается на нарушителя и пытается заломить ему руки")
	  wait(1500)
      sampSendChat("/me крепко держит нарушителя за руки, выводит его на улицу")
	  wait(1500)
	  sampSetChatInputEnabled(true)
      sampSetChatInputText("/expel " .. text_buffer.v )
	  end)
	  end
	    if imgui.Button(u8"Открытие дверей.") then
	  lua_thread.create(function()
	  sampSendChat("/do В правом кармане брюк лежит пластиковая ключ-карта для двери")
	  wait(1500)
      sampSendChat("/me достает карту из кармана и прикладывает к сканеру")
	  wait(1100)
	  setVirtualKeyDown(48, true)
	  wait(200)
      setVirtualKeyDown(48, false)
	  wait(1500)
	  sampSendChat("/me убирает пластиковую ключ-карту назад в карман.")
	  end)
	  end

	  -- 2 половина
	  imgui.NextColumn()
	  imgui.Text(u8"Банк меню:")
	  imgui.End()
	  end
	-- Рдс
	if show_report.v then
	imgui.SetNextWindowSize(imgui.ImVec2(280, 200), imgui.Cond.FirstUseEver)
	 imgui.SetNextWindowPos(imgui.ImVec2(870, 585), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
      imgui.Begin(u8'Ответы на репорт', show_report)
	  if imgui.Button(u8"Начать работу по жалобе") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}Начала работать по вашей жалобе. {FF00E6}|| Приятной игры на Russian Drift Server!")
		end
		if imgui.Button(u8"Уточните") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Пожалуйста уточните вашу жалобу")
		end
		if imgui.Button(u8"Ожидайте") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}Ожидайте. {FF00E6}|| Приятной игры на Russian Drift Server!")
		end
		if imgui.Button(u8"Попробую помочь") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}Сейчас попробую вам помочь. {FF00E6}|| Приятной игры на Russian Drift Server!")
		end
		if imgui.Button(u8"Слежу") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}Слежу. {FF00E6}|| Приятной игры на Russian Drift Server!")
		end
		if imgui.Button(u8"Не оффтопте") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF0000}Не оффтопте! {FF00E6}|| Приятной игры на Russian Drift Server! ")
		end
		if imgui.Button(u8"Проверим") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Проверим, ожидайте некотрое время")
		end
		if imgui.Button(u8"Приятной игры") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Приятной игры на Russian Drift Server!")
		end
		imgui.Separator()
		  if imgui.CollapsingHeader(u8'Ответы на вопросы') then
		  if imgui.CollapsingHeader(u8'Про вип') then
		   if imgui.Button(u8"Где взять обычный вип") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}У НПС на /trade за 10.000 очков")
			end
			 if imgui.Button(u8"Где взять премиум вип") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}У НПС на /trade за 10.000 очков")
			end
			if imgui.Button(u8"Где взять даймонд вип") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/donate > 4 пункт")
			end
			if imgui.Button(u8"Где взять платинум вип") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/donate > 5 пункт")
			end
			if imgui.Button(u8"Что может вип") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}Данную информацию узнайте в /help > 7 {FF00E6}Приятной игры на Russian Drift Server!")
			end
			end
			imgui.Separator()
		  if imgui.CollapsingHeader(u8'Про коины очки и деньги') then
	if imgui.Button(u8"Как заработать деньги, коины и очки") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Всю иформацию вы можете узнать в /help > 13")
			end
			if imgui.Button(u8"Куда тратить коины") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}На личное авто, клубы, аксесуары и т.д")
			end
			if imgui.Button(u8"Куда тратить очки") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}На личное авто, аксесуары, вип статусы, обменять и т.д")
			end
			if imgui.Button(u8"Куда тратить деньги") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}На личное покупку бизнесов, оружия и т.д")
			end
			if imgui.Button(u8"Как передать очки") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/givescore При наличии Даймонд Вип")
			end
			if imgui.Button(u8"Как передать коины") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}К сожалению никак. {FF00E6}|| Приятной игры на Russian Drift Server!")
			end
			if imgui.Button(u8"Как передать деньги") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}/givemoney id сумма {FF00E6}|| Приятной игры на Russian Drift Server!")
			end
			if imgui.Button(u8"Где обменять очки на вирыт или коины") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FFFFFF}У Армана на /trade {FF00E6}|| Приятной игры на Russian Drift Server!")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Про банду') then
			 if imgui.Button(u8"Как принять в банду") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > система банд > пригласить в банду")
			end
			if imgui.Button(u8"Как выйти из банды") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/gleave || Приятной игры на Russian Drift Server!")
			end
			if imgui.Button(u8"Система банд") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ситема банд.Там вы все найдете")
			end
			if imgui.Button(u8"Как создать") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > ситема банд > создать")
			end
			 if imgui.Button(u8"Цвета") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Посмотрите в интернете. Ссылка - https://basicweb.ru/html/html_colors.php")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Семья') then
			 if imgui.Button(u8"Как принять в семью") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/finvite. {FF0000}Приятной игры")
			end
			if imgui.Button(u8"Как создать") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/trade > у НПС Армана за 50.000 очков")
			end
			 if imgui.Button(u8"Как уйти из семью") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/familypanel > покинуть семью")
			end
			 if imgui.Button("familypanel") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/familypanel, там вы сможете это найти")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Ссылки') then
			if imgui.Button(u8"Ссылка на основателя") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Ссылка на вк основателя > vk.com/id139345872")
			end
			if imgui.Button(u8"Ссылка на кодера") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Кодер в ВК > vk.com/vipgamer228")
			end
			if imgui.Button(u8"Ссылка группы сервера") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Группа в ВК > vk.com/dmdriftgta")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Дом') then
			if imgui.Button(u8"Как купить дом") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Найти свободный, всать на пикап, нажать F > Купить")
			end
			if imgui.Button(u8"Как продать дом") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}В гос - /hpanel > продать дом.Продать дом игроку /sellmyhouse id цена")
			end
			if imgui.Button(u8"Как подселить в дом") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/hpanel > список жильцов > подселить")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Транспорт') then
			if imgui.Button(u8"Как взять авто") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > транспорт > тип транспорта")
			end
			if imgui.Button(u8"Как протюнинговать авто") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > транспорт > тюнинг")
			end
			if imgui.Button(u8"Как заспавнить л/ч авто") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/car > заспавнить")
			end
			if imgui.Button(u8"Как купить личное авто") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/tp > разное > автосалоны")
			end
			if imgui.Button(u8"Как продать л/ч авто") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}В гос - /car > продать авто.Продать игроку - /autoyartp")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Оружия') then
			if imgui.Button(u8"Как взять оружие") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > оружия")
			end
			if imgui.Button(u8"Как убрать оружие") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > оружия > убрать оружие")
			end
			end
			imgui.Separator()
			if imgui.CollapsingHeader(u8'Пункт настройки') then
			if imgui.Button(u8"Вход/выход игроков") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 1 пункт")
			end
			if imgui.Button(u8"Разрешение вызывать на дуель") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 2 пункт")
			end
			if imgui.Button(u8"Вкл/откл личные сообщения") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 3 пункт")
			end
			if imgui.Button(u8"Запросы на телепорт") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 4 пункт")
			end
			if imgui.Button(u8"Показ DM Статистики") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 5 пункт")
			end
			if imgui.Button(u8"Эфект при телепортации") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 6 пункт")
			end
			if imgui.Button(u8"Показывать спидометр") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 7 пункт")
			end
			if imgui.Button(u8"Показывать Дрифт Уровень") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 8 пункт")
			end
			if imgui.Button(u8"Спавн в доме/доме семью") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 9 пункт")
			end
			if imgui.Button(u8"Вызов главного меню") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 10 пункт")
			end
			if imgui.Button(u8"Вкк/Выкл приглашение в банду") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 11 пункт")
			end
			if imgui.Button(u8"Выбор ТС На текст драве") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 12 пункт")
			end
			if imgui.Button(u8"Вкл/Выкл кейс") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 13 пункт")
			end
			if imgui.Button(u8"Вкл/Выкл фпс показатель") then
			dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 15 пункт")
			end
			end
		  if imgui.CollapsingHeader(u8'Другое') then
	if imgui.Button(u8"Пишите жалобу") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Пишите жалобу в группу вк > vk.com/dmdriftgta")
			end
			if imgui.Button(u8"Посмотрите в интернете.") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Посмотрите в интренете")
			end
			if imgui.Button(u8"Нет") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Нет.Приятной игры")
			end
			if imgui.Button(u8"Не выдаем") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Не выдаем.")
			end
			if imgui.Button(u8"Не запрещенно") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Не запрещенно")
			end
			if imgui.Button(u8"Где взять кейс") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Он появится при наличии 100 милилонов на руках")
			end
			if imgui.Button(u8"Как вкл/выкл кейс") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/menu > настройки > 13 пункт")
			end
			if imgui.Button(u8"Как отправлять дуель") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}/duel id.Приятной игры")
			end
			if imgui.Button(u8"Перезайдите") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Попробйте перезайти на сервер")
			end
			if imgui.Button(u8"Никак") then
	dialogid = sampGetCurrentDialogId()
			sampSendDialogResponse(dialogid, 1, 0, "{FF00E6}Никак.Приятной игры")
			end
			end
			end
			imgui.End()
			end

  -- Pilot Window
  
  if show_pilot_window.v then
  imgui.SetNextWindowPos(imgui.ImVec2(10, 320), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
  imgui.Begin(u8'Панель пилота', show_pilot_window, imgui.WindowFlags.NoMove)
  imgui.Text(u8"Вас приветствует окно пилота.")
  imgui.Text(u8"Выберите нужную функцию указанную ниже")
  imgui.Separator()
  if imgui.Button(u8"Панель путей") then
		show_pilot_puti.v = not show_pilot_puti.v
		end
		imgui.SameLine()
  if imgui.Button(u8"Поприветствовать") then
  lua_thread.create(function()
  sampSendChat("/pt Добрый день коллеги.")
  wait(5200)
  sampSendChat("/pt Как ваши дела?")
  wait(5200)
  sampSendChat("/pt Как работа?")
  end)
  end
  if imgui.Button(u8"Дискорд") then
  lua_thread.create(function()
  sampSendChat("/pt Напоминаю вам что у нас есть свой дискорд сервер.")
  wait(5200)
  sampSendChat("/pt В нем сидят все пилоты.")
  wait(5200)
  sampSendChat("/pt Подключайся к нам :)  - https://discord.gg/Hgmzkj")
  wait(600000)
  sampSendChat("/pt Напоминаю вам что у нас есть свой дискорд сервер.")
  wait(5200)
  sampSendChat("/pt В нем сидят все пилоты.")
  wait(5200)
  sampSendChat("/pt Подключайся к нам :)  - https://discord.gg/Hgmzkj")
  wait(1061)
  sampAddChatMessage("{FF00E6}Отыгровка завершенна!")
  end)
  end
		imgui.End()
		end






  if show_pilot_puti.v then
  imgui.SetNextWindowPos(imgui.ImVec2(720, 410), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.Begin(u8'Панель путей', show_pilot_puti, imgui.WindowFlags.NoMove)
   imgui.Text(u8"Выберите путь по которому вы будете лететь.")
   imgui.Separator()
   if imgui.Button(u8'Лос Сантос -> Сан Фиеро') then
        lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Лос Сантос -> Сан Фиеро")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	if imgui.Button(u8'Лос Сантос -> Лас Вентурас') then
	lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Лос Сантос -> Лас Вентурас")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	if imgui.Button(u8'Сан Фиеро -> Лос Сантос') then
	lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Сан Фиеро -> Лос Сантос")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	if imgui.Button (u8'Сан Фиеро -> Лас Вентурас') then
	lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Сан Фиеро -> Лас Вентурас")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	if imgui.Button(u8'Лас Вентурас -> Лос Сантос') then
	lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Лас Вентурас -> Лос Сантос")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	if imgui.Button(u8'Лас Вентурас -> Сан Фиеро') then
	lua_thread.create(function()
		sampSendChat("/pt Рейс №461 готов к вылету.")
		wait(5200)
		sampSendChat("/pt Путь - Лас Вентурас -> Сан Фиеро")
		wait(5200)
		sampSendChat("/pt Прошу освободить полосу для взлета!")
		end)
	end
	imgui.End()
	end
   
   -- Документы
   if show_dokumenti.v then
   imgui.SetNextWindowPos(imgui.ImVec2(10, 510), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.Begin(u8"РП документы", show_dokumenti, imgui.WindowFlags.NoMove)
   imgui.PushItemWidth(30)
   imgui.InputText(u8"Введите ID игрока.", text_buffer)
   if imgui.Button(u8"Паспорт") then
   lua_thread.create(function()
   sampSendChat("/do В кармане у " .. nick .. " находится паспорт.")
   wait(2000)
   sampSendChat("/me " .. (lady and 'сунула' or 'сунул') .. " руку в карман")
   wait(2000)
   sampSendChat("/me " .. (lady and 'нащупала' or 'нащупал') .. " паспорт")
   wait(2000)
   sampSendChat("/me " .. (lady and 'вытащила' or 'вытащил') .. " паспорт из кармана")
   wait(2000)
   sampSendChat("/do Паспорт в руке.")
   wait(2000)
   sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " паспорт человеку на против")
   wait(2000)
   sampSendChat("/showpass " .. text_buffer.v)
   end)
   end
   imgui.SameLine()
    if imgui.Button(u8"Лицензии") then
   lua_thread.create(function()
   sampSendChat("/do В папке у " .. nick .. " находятся лицензии")
   wait(2000)
   sampSendChat("/me " .. (lady and 'открыла' or 'открыл') .. " папку")
   wait(2000)
   sampSendChat("/me " .. (lady and 'нащупала' or 'нащупал') .. " все лицензии")
   wait(2000)
   sampSendChat("/me " .. (lady and 'вытащила' or 'вытащил') .. " лицензии из папки")
   wait(2000)
   sampSendChat("/do Лицензии в руке.")
   wait(2000)
   sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " лицензии человеку на против")
   wait(2000)
  sampSendChat("/showlic " .. text_buffer.v)
   end)
   end
    imgui.SameLine()
    if imgui.Button(u8"Мед.Карта") then
   lua_thread.create(function()
   sampSendChat("/do В кармане у " .. nick .. " находется мед.карта")
   wait(2000)
   sampSendChat("/me " .. (lady and 'сунула' or 'сунул') .. " руку в карман")
   wait(2000)
   sampSendChat("/me " .. (lady and 'нащупала' or 'нащупал') .. " мед.карту")
   wait(2000)
   sampSendChat("/me " .. (lady and 'вытащила' or 'вытащил') .. " мед.карту из кармана")
   wait(2000)
   sampSendChat("/do Мед.карта в руке.")
   wait(2000)
   sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " мед.карту человеку на против")
   wait(2000)
  sampSendChat("/showmc " .. text_buffer.v)
   end)
   end
   
   imgui.End()
   end
   
   
   -- license
   
  if show_license.v then
  imgui.Begin('License', show_license)
		imgui.Text(u8'Выбирете действие')
		imgui.PushItemWidth(30)
		 imgui.InputText(u8"Введите ID игрока.", text_buffer)
		imgui.Separator()
		imgui.Text(u8'Информация:')
		imgui.Separator()
		if imgui.Button(u8"Поприветствовать") then
		lua_thread.create(function()
		sampSendChat('Здравствуйте, меня зовут Миа Картер, чем могу вам помочь?')
		wait(1200)
		sampSendChat('/do На груди весит бейджик с надписью: Консультант АШ, Миа Картер.')
		end)
		end
		if imgui.Button(u8"Прайс лист") then
		lua_thread.create(function()
		sampSendChat('/do В руке находится прайс-лист.')
		wait(1200)
		sampSendChat('/me передает прайс лист клиенту')
		wait(1200)
		sampSendChat('/do На прайс листе написанно:')
		wait(1200)
		sampSendChat('/do Лицензия на авто - 2.200$')
		wait(1200)
		sampSendChat('/do Лицензия на мото - 5.000$')
		wait(1200)
		sampSendChat('/do Лицензия на рыбаловство - 10.000$')
		wait(1200)
		sampSendChat('/do Лицензия на вождение водным т/с - 25.000$')
		wait(1200)
		sampSendChat('/do Лицензия на оружие - 20.000$')
		wait(1200)
		sampSendChat('/do Лицензия на охоту - 200.000$')
		wait(1200)
		sampSendChat('/do Лицензия на полеты - Можно ролучить в Авиашколе')
		end)
		end
		imgui.Separator()
		imgui.Text(u8'Лицензии:')
		imgui.Separator()
		if imgui.Button(u8"Выдача лицензии") then
		lua_thread.create(function()
		sampSendChat('/todo Хорошо, минуточку *повернув КПК в свою сторону и что-то выбирая на нем')
		wait(2200)
		sampSendChat('/do На КПК выбрана нужная лицензия, и показана соответствующая цена.')
		wait(2200)
		sampSendChat('/me подтверждает выбор лицензии')
		wait(2200)
		sampSendChat('/do КПК печатает чек.')
		wait(2200)
		sampSendChat('/do Чек готов.')
		wait(2200)
		sampSendChat('/do На чеке написана сумма оплаты.')
		wait(2200)
		sampSendChat("/me " .. (lady and 'передала' or 'передал') .. " чек человеку на против")
		wait(2200)
		sampSendChat("/me " .. (lady and 'ввела' or 'ввел') .. " данные гражданина в КПК")
		wait(2200)
		sampSendChat('/do Данные введены верно.')
		wait(2200)
		sampSendChat("/givelicense " .. text_buffer.v)
		wait(2000)
		sampSendChat('Вот ваша лицензия, всего Вам хорошего!')
		end)
		end
		if imgui.Button(u8"Попросить мед.карту") then
		lua_thread.create(function()
		sampSendChat('Для покупки лицензии на оружие необходимо предъявить вашу мед.карту')
		wait(1200)
		sampSendChat('/b Что-бы показать мед.карту введите /showmc ')
		end)
		end
		imgui.End()
		end

	-- Standard ImGui
if show_imgui_example.v then
		imgui.Begin('ImGui example', show_imgui_example)
		imgui.Text('Hello, world!')
		imgui.SliderFloat('float', slider_float, 0.0, 12.0)
		imgui.ColorEdit3(u8'Цвета', clear_color)
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
	

	


     sampAddChatMessage("{FF0000}[Dadaya Helper] {FFFFFF}Загружен!")
	 

	 	downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.info.vers_text, -1)
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
                    sampAddChatMessage("Скрипт успешно обновлен!", -1)
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
    sampShowDialog(1000, "Автообновление v2.0", "{FFFFFF}Это урок по обновлению\n{FFF000}Новая версия", "Закрыть", "", 0)
end