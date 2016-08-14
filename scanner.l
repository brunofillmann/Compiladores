
%{

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "tokens.h"
#include "hash.h"

extern HASH_NODE *Table[HASH_SIZE];

int running = 1;
int linecounter = 0;

int getLineNumber(void);
int isRunning(void);

%}

	
%x IN_COMMENT

%%
<<EOF>>				{ printf("EOF\n\n");	running = 0;	return 0;}		
[\t ]				{ ; }
"//".*\n 			{ linecounter++;	printf("Comment: %d\n\n", linecounter);}
\n					{ linecounter++;	printf("Line: %d\n\n", linecounter);}


<INITIAL>{
     "/*"              BEGIN(IN_COMMENT);
     }
<IN_COMMENT>{
     "*/"      BEGIN(INITIAL);
     [^*\n]+   
     "*"       
     \n        linecounter++; printf("Line: %d\n\n", linecounter);
     }






"int"				{ printf("INT\n\n"); 	return KW_INT; 		}
"float"				{ printf("FLOAT\n\n");  return KW_FLOAT; 	}
"bool"				{ printf("BOOL\n\n"); 	return KW_BOOL; 	}
"char"				{ printf("CHAR\n\n"); 	return KW_CHAR; 	}
"if"				{ printf("IF\n\n"); 	return KW_IF; 		}
"then"              { printf("THEN\n\n"); 	return KW_THEN; 	}
"else"				{ printf("ELSE\n\n"); 	return KW_ELSE; 	}
"for"				{ printf("FOR\n\n"); 	return KW_FOR; 		}
"read"				{ printf("READ\n\n"); 	return KW_READ; 	}
"print"				{ printf("PRINT\n\n"); 	return KW_PRINT; 	}
"return"			{ printf("RETURN\n\n"); return KW_RETURN; 	}

"<="				{ printf("<=\n\n"); 	return OPERATOR_LE; 	}
">="				{ printf(">=\n\n"); 	return OPERATOR_GE; 	}
"=="				{ printf("==\n\n"); 	return OPERATOR_EQ; 	}
"!="				{ printf("!=\n\n"); 	return OPERATOR_NE; 	}
"&&"				{ printf("&&\n\n"); 	return OPERATOR_AND; 	}
"||"				{ printf("||\n\n"); 	return OPERATOR_OR; 	}

[-,;:(){}\[\]+*/<>!&$=] { printf("Special Character '%c'\n\n", yytext[0]); return yytext[0]; }



"TRUE"						{ printf("TRUE\n\n"); hashInsert(LIT_TRUE, yytext); return LIT_TRUE;}
"FALSE"						{ printf("FALSE\n\n"); hashInsert(LIT_FALSE, yytext); return LIT_FALSE;}
[a-zA-Z][a-zA-Z0-9_]*		{ printf("ID\n\n"); hashInsert(TK_IDENTIFIER, yytext); return TK_IDENTIFIER; 	}
[0-9]+						{ printf("LIT INT\n\n"); hashInsert(LIT_INTEGER, yytext); return LIT_INTEGER; 	}
\'([^\\\"]|\\.)\'			{ printf("CHAR\n\n"); hashInsert(LIT_CHAR, yytext); return LIT_CHAR; 		}
\"([^\\\"]|\\.)*\"			{ printf("STRING\n\n"); hashInsert(LIT_STRING, yytext); return LIT_STRING; 	}

.        { return TOKEN_ERROR;}


		


%%



int getLineNumber(void)
{
	return linecounter;
}

int isRunning(void)
{
	return running;
}

int yywrap(void)
{
	running = 0;
	return 1;
}


