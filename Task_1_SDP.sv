// --------------------------------------------------------------------
// Universitat Politècnica de València
// Departamento de Ingeniería Electronica
// --------------------------------------------------------------------
// Sistemas Digitales Programables MUISE
// Curso 2026 - 2027
// --------------------------------------------------------------------
// Nombre del archivo: Task_1_SDP.sv
//
// Descripción: Este código Verilog implementa un contador de n bits con
// la siguiente funcionalidad de sus entradas y salidas:
// 1. Contador síncrono ascendente - descendente de módulo parametrizable
//		fin_cuenta.
// 2. Funcionamiento por flanco de subida del reloj.
// 3. Reset, síncrono (máxima prioridad), activo a nivel bajo.
// 4. Entrada de habilitación de cuenta enable que habilita la cuenta.
// 5. Si la entrada UP_DOWN está a nivel alto, el contador cuenta hacia 
//		arriba. De lo contrario, cuenta hacia abajo.
// 6. Señal de salida TC activa cuando el contador llega al fin de cuenta.
// 7. Utilizar la Familia Cyclone IV E de intelFPGA.
// --------------------------------------------------------------------
// Versión: V1.0 | Fecha Modificación: 02/10/2026
//
// Autor(es): Edgar Paez y Jonnathan Arevalo.
// Ordenador de trabajo: local
//
// --------------------------------------------------------------------



module Counter(iCLK, iRST_n, iENABLE, iUP_DOWN, oCOUNT, oTC);

	parameter fin_cuenta = 20;
	`include "MathFun.svh"
	localparam int N = CLogB2(fin_cuenta);
	input logic iCLK, iRST_n, iENABLE, iUP_DOWN;
	output logic [N-1:0] oCOUNT;
	output logic oTC;
	
	always_comb begin
		if(iUP_DOWN ==1 && iENABLE == 1)
			oTC = (oCOUNT == fin_cuenta-1) ? 1 : 0;
		else if(iUP_DOWN == 0 && iENABLE == 1)
			oTC = (oCOUNT == 0) ? 1 : 0;
		else
			oTC = 0;
	end

	always_ff @(posedge iCLK) begin // always_ff (always flipflop/secuencial): bloque de código que se ejecuta en el flanco de subida del reloj
		if(iRST_n == 0) // reset síncrono activo bajo
			oCOUNT <= 0;
		else if(iENABLE == 1 && iUP_DOWN == 1) begin
			if(oCOUNT == fin_cuenta-1)
				oCOUNT <= 0;
			else
				oCOUNT <= oCOUNT + 1;
		end
		else if(iENABLE == 1 && iUP_DOWN == 0) begin
			if(oCOUNT == 0)
				oCOUNT <= fin_cuenta-1;
			else
				oCOUNT <= oCOUNT - 1;
		end
		else
			oCOUNT <= oCOUNT;
	end

endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	