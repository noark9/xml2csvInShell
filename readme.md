#xml2csv

Shell tool for simple xml parse. I need a tool to convert xml file to csv file simple, fast and easy to use and configure.So I create this tool for simple xml file parse.

usage

	./xml2csv.sh

##Example

Edit awk.conf file to configure how program acts.

	length(a)>4:test:table:a,b,c,{9},c(3,5)

This will parse a tag named test which have three child tags(a, b, c) in a xml file.

	<item>
		<a>3</a>
		<b>4</b>
		<c>1234567890</c>
		<d>9</d>
	</item>
	<item>
		<a>5</a>
		<b>4</b>
		<c>abcdefghiu</c>
		<d>9</d>
	</item>

`table` is output file name. File above will output like this:

	5,6,abcdefghiu,9,cdefg

into a file named table.csv

`length(a)>4` indicate that parse only a is greater then 4. You can use awk functions and also `||`, `&&` for complex condition.

`{9}` indicate that show 9 in the right place.

`c(3,5)` is substring c from 3 get 5 char.
