; FUNCIONA BIEN LO UNICO QUE TIENE ES QUE SI NO INGRESAS POR EJEMPLO NINGUNA COMA
;CUANDO IMPRIME LA CANTIDAD DE LA COMA IMPRIME 048
; PERO SI INGRESAS LOS 3 TIPOS DE DATOS IMPRIME BIEN SUS RESULTADOS
;
.8086
.model small
.stack 100h
.data
cartel1 db "Ingrese un texto de hasta 255 caracteres",0dh,0ah,24h
texto db 255 dup (30h) ,0dh,0ah,24h
cantvocales db "La cantidad de vocales ingresadas es de",0dh,0ah,24h
cantpuntos db "La cantidad de puntos ingresados es de",0dh,0ah,24h
cantcomas db "La cantidad de comas ingresadas es de ",0dh,0ah,24h
vocales db 3 dup(30h),0dh,0ah,24h
puntos db 3 dup(30h),0dh,0ah,24h
comas db 3 dup(30h),0dh,0ah,24h

valorvocal db 3 dup(30h),0dh,0ah,24h
valorpunto db 3 dup(30h),0dh,0ah,24h
valorcoma db 3 dup(30h),0dh,0ah,24h
.code
main proc

        mov ax, @data
        mov ds, ax


        mov ah,9
        mov dx, offset cartel1  ; imprimo cartel de entrada
        int 21h

        mov dx,0
        mov ax,0

      mov cx,0  ; en cx voy guardando la cantidad de digitos ingresados
carga:
        cmp ch,255   ; comparo con 255 para finalizar
        je finentrada
        mov ah,1
        int 21h
        cmp al,0dh     ; comparo con enter para finalizar
        je finentrada
        cmp al,41h     ; comparo con A 
        je contarvocales
        cmp al,45h     ; comparo con E
        je contarvocales 
        cmp al,49h      ; comparo con I
        je contarvocales
        cmp al,4fh       ; comparo con O
        je contarvocales
        cmp al,55h         ; comparo con  U
        je contarvocales
        cmp al,61h        ; comparo con a
        je contarvocales
        cmp al,65h          ; comparo con e
        je contarvocales
        cmp al,69h          ; comparo i
        je contarvocales
        cmp al,6fh         ; comparo con o
        je contarvocales
        cmp al,75h          ; comparo con u
        je contarvocales
        cmp al,2eh         ; comparo con el punto
        je contarpuntos
        cmp al,2ch        ;comparo con la coma 
        je contarcomas
        mov texto[bx],al  ; guardo en texto[bx] el valor ingresado
        inc bx
        inc ch
        jmp carga





contarvocales:
                inc dh               ; aca guardo cuantas vocales
                mov valorvocal[0],dh  ;guardo el valor para usarlo despues
                inc bx
                inc ch
                jmp carga

contarpuntos:
            inc dl    ; aca guardo cuantos puntos
            mov valorpunto[0],dl
            inc bx
            inc ch
            jmp carga


contarcomas:        
            inc cl   ; aca guardo cuantas comas
            mov valorcoma[0],cl
            inc bx 
            inc ch
            jmp carga



finentrada:

    cargavocal:       
        mov ax,0

        mov al,valorvocal[0]          ;cargo el numero a imprimir
        mov dl,10
        div dl               ; ejecuto la instruccion de dividir indicando el divisor(10)
        add vocales[2],ah   ;guardo unidad
        xor ah,ah       
        div dl
        add vocales[1],ah   ; guardo decena (en ah esta el resto de la division)
        xor ah,ah
        div dl
        add vocales[0],ah  ; guardo centena (en ah esta el resto de la division)
        jmp imprimirvocal

    cargapuntos:
        mov ax,0
        mov bx,0

        mov al,valorpunto[0]            ;cargo el numero a imprimir
        mov bl,10
        div bl               ; ejecuto la instruccion de dividir indicando el divisor(10)
        add puntos[2],ah   ;guardo unidad
        xor ah,ah       
        div bl
        add puntos[1],ah   ; guardo decena (en ah esta el resto de la division)
        xor ah,ah
        div bl
        add puntos[0],ah  ; guardo centena (en ah esta el resto de la division)
        jmp imprimirpuntos

    cargacomas:
        mov ax,0
        mov bx,0

        mov al,valorcoma[0]          ;cargo el numero a imprimir
        mov bl,10
        div bl               ; ejecuto la instruccion de dividir indicando el divisor(10)
        add comas[2],ah   ;guardo unidad
        xor ah,ah       
        div bl
        add comas[1],ah   ; guardo decena (en ah esta el resto de la division)
        xor ah,ah
        div bl
        add comas[0],ah  ; guardo centena (en ah esta el resto de la division)
        jmp imprimircomas



            
 imprimirvocal:       
            mov ah,9
            mov dx,offset cantvocales   ; imprimo cartel de cantidad
            int 21h

            mov ah,9
            mov dx,offset vocales    ; imprimo numero de vocales
            int 21h

            jmp cargapuntos
;-------------------------------------------------------------------------------
 imprimirpuntos:
            mov ah,9
            mov dx,offset cantpuntos   ; imprimo cartel de cantidad
            int 21h

            mov ah,9
            mov dx,offset puntos    ; imprimo numero de puntos
            int 21h

            jmp cargacomas
;------------------------------------------------------------------------------------
 imprimircomas:
            mov ah,9
            mov dx,offset cantcomas  ; imprimo cartel de cantidad
            int 21h

            mov ah,9
            mov dx,offset comas     ; imprimo numero de comas
            int 21h

            jmp fin2
;----------------------------------------------------------------------------------------



 fin2:       
        mov ax,4C00h

        int 21h

main endp

end main