--[[--
 @package   Contact
 @filename  src/contact.lua
 @version   3.0
 @autor     Diaz Urbaneja Victor Diego Alejandro <sodomon2@gmail.com>
 @date      04.03.2021 22:57:07 -04
]]

function poblar_lista()
	db:open()
	ui.lista_contactos:clear()
	local sql = "select * from contactos order by id_contacto desc"
	local consulta = db:get_results(sql)

	for i,item in pairs(consulta) do
		ui.lista_contactos:append({
			item.id_contacto,
			item.nombre,
			item.numero,
			item.lugar,
			item.fecha_registro
		})
	end
end
poblar_lista()

function insert_data()
	db:open()
	local sql = "insert into contactos(nombre,numero,lugar) values('"..ui.entry_name.text.."','"..ui.entry_number.text.."','"..ui.entry_city.text .."')"
	local _numero = tonumber(ui.entry_number.text)
	if ui.entry_name.text ~= "" and _numero ~= "" and ui.entry_city.text ~= "" then
		if (db:query(sql) == false) then
			print(sql)
		else
			poblar_lista()
			ui.entry_number.text = ""
			ui.entry_name.text = ""
			ui.entry_city.text  = ""

			notification("Agenda Personal", "Contacto añadido correctamente")
		end
	else
		print("error campos vacios")
	end
end
