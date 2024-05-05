package compiladorapp;
import java_cup.runtime.Symbol;
%%
%class LexerCup
%type java_cup.runtime.Symbol
%cup
%full
%line
%char
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
    public Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
    public Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
%}
%%

/* Caracteres a ignorar */
{Comentario} | {EspacioEnBlanco} | {TerminadorDeLinea} | {Comillas} { /* Ignorar */ }

/* Palabras reservadas */
("public") { return new Symbol(sym.Public, yychar, yyline, yytext()); }
("private") { return new Symbol(sym.Private, yychar, yyline, yytext()); }
("class") { return new Symbol(sym.Class, yychar, yyline, yytext()); }
("void") { return new Symbol(sym.Void, yychar, yyline, yytext()); }
("int") { return new Symbol(sym.Int, yychar, yyline, yytext()); }
("double") { return new Symbol(sym.Double, yychar, yyline, yytext()); }
("String") { return new Symbol(sym.String, yychar, yyline, yytext()); }
("new") { return new Symbol(sym.New, yychar, yyline, yytext()); }
("nextLine") { return new Symbol(sym.NextLine, yychar, yyline, yytext()); }
("nextInt") { return new Symbol(sym.NextInt, yychar, yyline, yytext()); }
("nextDouble") { return new Symbol(sym.NextDouble, yychar, yyline, yytext()); }
("println") { return new Symbol(sym.Println, yychar, yyline, yytext()); }
("if") { return new Symbol(sym.If, yychar, yyline, yytext()); }
("else") { return new Symbol(sym.Else, yychar, yyline, yytext()); }
("do") { return new Symbol(sym.Do, yychar, yyline, yytext()); }
("while") { return new Symbol(sym.While, yychar, yyline, yytext()); }
("switch") { return new Symbol(sym.Switch, yychar, yyline, yytext()); }
("case") { return new Symbol(sym.Case, yychar, yyline, yytext()); }
("default") { return new Symbol(sym.Default, yychar, yyline, yytext()); }

/* Identificador */
{Identificador} { return new Symbol(sym.Identificador, yychar, yyline, yytext()); }

/* Constante entera */
{ConstanteEntera} { return new Symbol(sym.C_entera, yychar, yyline, yytext()); } 

/* Constante real */
{ConstanteReal} { return new Symbol(sym.C_real, yychar, yyline, yytext()); } 

/* Constante String */
{ConstanteString} { return new Symbol(sym.C_String, yychar, yyline, yytext()); }

/* Operadores aritmeticos */
("+") {return new Symbol(sym.Mas, yychar, yyline, yytext());}
("-") {return new Symbol(sym.Menos, yychar, yyline, yytext());}
("*") {return new Symbol(sym.Por, yychar, yyline, yytext());}
("/") {return new Symbol(sym.Division, yychar, yyline, yytext());}
("%") {return new Symbol(sym.Modulo, yychar, yyline, yytext());}
("=") {return new Symbol(sym.Igual, yychar, yyline, yytext());}

/* Operadores relacionales */
("<") {return new Symbol(sym.Menor_que, yychar, yyline, yytext());}
("<=") {return new Symbol(sym.Menor_igual_que, yychar, yyline, yytext());}
(">") {return new Symbol(sym.Mayor_que, yychar, yyline, yytext());}
(">=") {return new Symbol(sym.Mayor_igual_que, yychar, yyline, yytext());}
("==") {return new Symbol(sym.Exactamente_igual_que, yychar, yyline, yytext());}
("!=") {return new Symbol(sym.Diferente_que, yychar, yyline, yytext());}

/* Operadores logicos */
("!") {return new Symbol(sym.No_es, yychar, yyline, yytext());}
("&&") {return new Symbol(sym.Y, yychar, yyline, yytext());}
("||") {return new Symbol(sym.O, yychar, yyline, yytext());}

/* Caracteres */
(";") {return new Symbol(sym.P_coma, yychar, yyline, yytext());}
("[") {return new Symbol(sym.Corchete_a, yychar, yyline, yytext());}
("]") {return new Symbol(sym.Corchete_c, yychar, yyline, yytext());}
(",") {return new Symbol(sym.Coma, yychar, yyline, yytext());}
(":") {return new Symbol(sym.Dos_puntos, yychar, yyline, yytext());}
("(") {return new Symbol(sym.Parentesis_a, yychar, yyline, yytext());}
(")") {return new Symbol(sym.Parentesis_c, yychar, yyline, yytext());}
("{") {return new Symbol(sym.Llave_a, yychar, yyline, yytext());}
("}") {return new Symbol(sym.Llave_c, yychar, yyline, yytext());}

/* Error de analisis */
 . {return new Symbol(sym.ERROR, yychar, yyline, yytext());}  