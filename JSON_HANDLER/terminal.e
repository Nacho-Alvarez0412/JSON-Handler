note
	description: "Summary description for {TERMINAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TERMINAL

create
	make

feature  -- Initialization
	json_manager : JSON_MANAGER

	make
		do
			create json_manager.make
			start_menu
		end

feature -- Functions
-- ====================================================================================
	start_menu
		do
			Io.put_string ("WELCOME TO JSON HANDLER %N")
			Io.new_line
			Io.put_string ("What do you want to do?... %N")
			Io.new_line
			Io.put_string ("1.Load a csv file %N")
			Io.put_string ("2.Save as a JSON file %N")
			Io.put_string ("3.Save as a csv file %N")
			Io.put_string ("4.Execute a SELECT query %N")
			Io.put_string ("5.Project a given JSON structure %N")
			Io.put_string ("6.Exit %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Select an option (Choose a number from 1-6):  ")
			Io.read_integer

			if Io.last_integer = 1 then
				load_csv_menu
			elseif Io.last_integer = 2 then
				print("about to save a JSON file")
			elseif Io.last_integer = 3 then
				print("about to load a csv file")
			elseif Io.last_integer = 4 then
				print("about to realize a query")
			elseif Io.last_integer = 5 then
				print("about to project a JSON")
			elseif Io.last_integer = 6 then
				print("Quitting")
			else
				print("Invalid option selected")
			end
		end
-- ====================================================================================
	load_csv_menu
		do
			Io.new_line
			Io.new_line
			Io.new_line
			Io.put_string ("LOAD A CSV FILE %N")
			Io.new_line
			Io.put_string ("For usage execute the command with the following syntax... %N")
			Io.put_string ("load [Name for storage] [Path] %N")
			Io.new_line
			Io.new_line
			Io.put_string ("Enter command: ")
			Io.read_line
			get_load_values
			Io.new_line
			Io.new_line
			Io.put_string ("Press any key to go back to start menu...")
			Io.read_line
			Io.new_line
			Io.new_line
			start_menu
		end
-- ====================================================================================
	get_load_values
	local
		path : STRING
		identifier : STRING
		words : ARRAYED_LIST [STRING]
		do
			create words.make(0)
			words := get_words(io.last_string)

			identifier := words.at (2)
			path := words.at (3)
			json_manager.load_file (path)
			json_manager.save_to_hash (identifier)
		end
-- ====================================================================================
	get_words(string : STRING) : ARRAYED_LIST [STRING]
	local
		words : ARRAYED_LIST [STRING]
		word : STRING
		do
			create word.make_empty
			create words.make (0)
			across string as char loop
			    if char.item = ' '
				then
				    words.extend (word)
				    word := ""
				else
				    word.append_character (char.item)
				end
			end
			words.extend (word)
			RESULT := words
		end
-- ====================================================================================
end