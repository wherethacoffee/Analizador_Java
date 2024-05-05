package compiladorapp;
import static compiladorapp.Tokens.*;  
%%
%class Lexer
%type Tokens
%line
%column

/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
Comentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
Comillas = "\""

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Constantes */
ConstanteEntera = [-+]?{Digito}+
ConstanteReal = [-+]?({Digito}+\.{Digito}*|\.{Digito}+)
ConstanteString = "\"" [^\r\n\"]* "\""

%{
    public String lexeme;
    public int valor, linea, columna, posTabla;
%}
%%

{Comentario} | {EspacioEnBlanco} | {TerminadorDeLinea} | {Comillas} { /* Ignorar */ }

/* Palabras reservadas */
"public" { lexeme=yytext(); valor=-1; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Public; }
"private" { lexeme=yytext(); valor=-2; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Private; }
"class" { lexeme=yytext(); valor=-3; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Class; }
"void" { lexeme=yytext(); valor=-4; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Void; }
"int" { lexeme=yytext(); valor=-5; linea=yyline+1+1; columna=yycolumn+1; posTabla=-1; return Int; }
"double" { lexeme=yytext(); valor=-6; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Double; }
"String" { lexeme=yytext(); valor=-7; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return String; }
"new" { lexeme=yytext(); valor=-8; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return New; }
"nextLine" { lexeme=yytext(); valor=-9; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return NextLine; }
"nextInt" { lexeme=yytext(); valor=-10; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return NextInt; }
"nextDouble" { lexeme=yytext(); valor=-11; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return NextDouble; }
"println" { lexeme=yytext(); valor=-12; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Println; }
"if" { lexeme=yytext(); valor=-13; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return If; }
"else" { lexeme=yytext(); valor=-14; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Else; }
"do" { lexeme=yytext(); valor=-15; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Do; }
"while" { lexeme=yytext(); valor=-16; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return While; }
"switch" { lexeme=yytext(); valor=-17; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Switch; }
"case" { lexeme=yytext(); valor=-18; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Case; }
"default" { lexeme=yytext(); valor=-19; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Default; }

/* Identificador */
{Identificador} { lexeme=yytext(); valor=-22; linea=yyline+1; columna=yycolumn+1; posTabla=-2; return Identificador; }

/* Constante entera */
{ConstanteEntera} { lexeme=yytext(); valor=-23; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return C_entera; }

/* Constante real */
{ConstanteReal} { lexeme=yytext(); valor=-21; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return C_real; }

/* Constante string */
{ConstanteString} { lexeme=yytext(); valor=-20; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return C_String; }


/* Operadores aritmeticos */
"+" { lexeme=yytext(); valor=-24; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Mas; }
"-" { lexeme=yytext(); valor=-25; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Menos; }
"*" { lexeme=yytext(); valor=-26; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Por; }
"/" { lexeme=yytext(); valor=-27; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Division; }
"%" { lexeme=yytext(); valor=-28; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Modulo; }
"=" { lexeme=yytext(); valor=-29; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Igual; }

/* Operadores relacionales */
"<" { lexeme=yytext(); valor=-30; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Menor_que; }
"<=" { lexeme=yytext(); valor=-31; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Menor_igual_que; }
">" { lexeme=yytext(); valor=-32; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Mayor_que; }
">=" { lexeme=yytext(); valor=-33; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Mayor_igual_que; }
"==" { lexeme=yytext(); valor=-34; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Exactamente_igual_que; }
"!=" { lexeme=yytext(); valor=-35; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Diferente_que; }

/* Operadores logicos */
"!" { lexeme=yytext(); valor=-36; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return No_es; }
"&&" { lexeme=yytext(); valor=-37; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Y; }
"||" { lexeme=yytext(); valor=-38; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return O; }

/* Caracteres */
";" { lexeme=yytext(); valor=-39; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return P_coma; }
"[" { lexeme=yytext(); valor=-40; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Corchete_a; }
"]" { lexeme=yytext(); valor=-41; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Corchete_c; }
"," { lexeme=yytext(); valor=-42; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Coma; }
":" { lexeme=yytext(); valor=-43; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Dos_puntos; }
"(" { lexeme=yytext(); valor=-44; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Parentesis_a; }
")" { lexeme=yytext(); valor=-45; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Parentesis_c; }
"{" { lexeme=yytext(); valor=-46; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Llave_a; }
"}" { lexeme=yytext(); valor=-47; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return Llave_c; }

. { lexeme=yytext(); valor=0; linea=yyline+1; columna=yycolumn+1; posTabla=-1; return ERROR; }
