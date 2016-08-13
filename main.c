
//--------------------------------------------//
// ALUNOS: TAGLINE TREICHEL e BRUNO FILLMANN
//--------------------------------------------//

#include <stdio.h>

void main() {

	extern FILE* yyin;
	yyin=fopen("testfile","r");
//	yylex();

	while(isRunning())
	{
		yylex();
	}

	hashPrint();


}

