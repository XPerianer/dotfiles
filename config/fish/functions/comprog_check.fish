function comprog_check
	if test 2 -ne (count $argv)
		echo "Usage: executable test_folder"
	end

	set all_good 0

	set executable $argv[1]
	set test_folder $argv[2]

	for input in $test_folder/*.in
		echo "Testcase: $input"

		set answer (./$executable < $input)
		set out_path (string split -r -m1 . $input)[1].out
		set correct_answer (cat $out_path)
		diff (echo $answer | psub) (echo $correct_answer | psub) --color
		if test $status -eq 1
			set all_good 1
			echo -e "      Fail"
		else
			echo -e "      Good"
		end
	end

	if test $all_good -eq 0
		set_color green
		echo "Success"
	else
		set_color red
		echo "Failure"
	end
	set_color normal
end
