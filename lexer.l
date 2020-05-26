%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%option noyywrap

com [^*/]

num [0-9]+
id [a-zA-Z_][a-zA-Z_0-9]*
cadena [a-zA-Z]+
caracter [a-zA-Z]
void ("sin")
estructura ("estructura")
inicio ("inicio")
fin ("fin")


programa {declaraciones}{funciones}
instruc1 {tipo}{lista_var}";"
instruc2 {tipo_registro}{lista_var}";"
declaraciones ({instruc1}+|{instruc2}+)*
tipo_registro {estructura}{inicio}{declaraciones}{fin}
tipo ({base}" "{tipo_arreglo})
base ("real")|("ent")|("dreal")|("car")|("real")|{void}
arreglo_t  ("("{num}")")
tipo_arreglo ({arreglo_t}+)*
lista_var ({var}|{id})+
var ","{id}
funcion ("def")" "{tipo}" "{id}("("{argumentos}")")" "{inicio}" "{declaraciones}" "{sentencias}" "{fin}
funciones {funcion}*
argumentos ({lista_arg}|{void})
lista_arg ({lista}|{arg})+
lista ","{arg}
arg {tipo_arg}(""|" "){id}
tipo_arg {base}" "{param_arr}+
param_arr ("("")")*

sentencias({sent_1}|{sentencia})+
sent_1 {sentencia}
/*15*/


caso  ("caso")" "{num}(":"){sentencia}
casos {caso}+
predeterminado (("pred:")" "{sentencia}|("pred:"){sentencia})*

e_bool2 {relacional}|("verdadero")|("falso")
e_bool1 {e_bool2}|{e_bool2}"o"{e_bool2}|{e_bool2}"y"{e_bool2}|"no"" "{e_bool2}
e_bool ("("{e_bool1}")")|{e_bool1}

rel2 {relacional}|{expresion}
rel1 {rel2}">"{rel2}|{rel2}"<"{rel2}|{rel2}"<="{rel2}|{rel2}">="{rel2}|{rel2}"<>"{rel2}|{rel2}"="{rel2}
relacional {rel1}|{rel2}

exp2 {variable}|{num}|{cadena}|{caracter}|expresion
exp1 {exp2}|{exp2}"+"{exp2}|{exp2}"-"{exp2}|{exp2}"*"{exp2}|{exp2}"/"{exp2}|{exp2}"%"{exp2}
expresion ("("{exp1}")")|{exp1}

variable {id}" "{variable_comp}|{id}{variable_comp}
variable_comp {dato_est_sim}|{arreglo}|("("{parametros}")")
dato_est_sim ({est_sim})*
est_sim "."{id}
arreglo_1 ("("{expresion}")")
arreglo {arreglo_1}|({arreglo_1}("("{expresion}")"))
parametros {lista_param}*
lista_param ({lista_p}|{expresion})
lista_p ","{expresion}

%%
{base} {printf("Encontre una base: %s \n", yytext);}
{param_arr} {printf("Encontre un param_arr: %s \n", yytext);}
{tipo_arg} {printf("Encontre un tipo_arg: %s \n", yytext);}
{arg} {printf("Encontre un arg: %s \n", yytext);}
{lista_arg} {printf("Encontre un lista_arg: %s \n", yytext);}
{argumentos}+ {printf("Encontre unos argumenos: %s \n", yytext);}
{lista_var} {printf("Encontre un lista_var: %s \n", yytext);}
{tipo_arreglo} {printf("Encontre un tipo_arreglo: %s \n", yytext);}
{tipo} {printf("Encontre un tipo: %s \n", yytext);}


[ \t\n\r]+ {/*ignorar espacios en blanco*/}
"/*"{com}*"*/" {/*ignorar comentarios*/}
.   { printf("Error Lexico: %s\n", yytext);}
%%
