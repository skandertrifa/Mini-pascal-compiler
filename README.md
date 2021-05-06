# Mini-pascal-compiler
 ## Instructions 
 In order to generate your own .exe file
 First install FLEX and BISON
 Then go to Resources folder follow these simple steps
 ```
flex exemple.flex ( lexicale )
bison -d exemple.y ( semantique )
gcc exemple.tab.c lex.y.c  ( a.exe file ) (-o to specify the name of the outpule .exe file )
```
then simple run put in main folder and rename it to "compilateur.exe". DONE
Now simply run the python application.

Or Execute without the interface ( `a.exe < file_source.txt `) .

If you found this helpful, consider helping me by giving me a star. Thank you 😊
