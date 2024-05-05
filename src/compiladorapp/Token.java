
package compiladorapp;

public class Token {
    private int valor;
    private String lexema;
    private Tokens token;
    private int linea;
    private int columna;
    private int posTabla;
    

    public Token(int val, String lex, Tokens tkn, int lin, int col, int pt) {
        this.valor = val;
        this.lexema = lex;
        this.token = tkn;
        this.linea = lin;
        this.columna = col;
        this.posTabla = pt;
    }

    public String getLexema() {
        return lexema;
    }

    public Tokens getToken() {
        return token;
    }

    public int getValor() {
        return valor;
    }

    public int getLinea() {
        return linea;
    }

    public int getColumna() {
        return columna;
    }

    public int getPosTabla() {
        return posTabla;
    }

}
