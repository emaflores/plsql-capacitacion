/*
Crear una funci�n f_get_salary que reciba por par�metro el ID del empleado y cuyo valor de retorno sea:
- el salario del empleado si todo fue ok
- el n�mero "-1" si hubo un error.
Adem�s la funci�n tiene que tener como par�metro de salida una descripci�n del error que se puede haber producido. 
En el gestor de excepciones manejar dos excepciones:
- si el empleado no existe
- la excepci�n general.

Luego crear un bloque an�nimo que llame a la funci�n f_get_salary, 
eval�e el resultado devuelto y, si es = a -1 mostrar el mensaje de error, 
y si es distinto mostrar el mensaje "El salario del empleado xxx es $xxx."
*/

/* Emanuel Flores - 14/04/2020 */
create or replace function f_get_salary (id_e employees.employee_id%type,
                                          err out varchar2) 
return number is
  salario employees.salary%type := -1;
begin
	select salary into salario from employees where employee_id = id_e;
  --si todo salio ok, devolver salario
  return salario;
exception
	when no_data_found then
		dbms_output.put_line('el empleado no existe');
    err := sqlerrm;
    return salario;
  when others then
		dbms_output.put_line(sqlerrm);
    err := sqlerrm;
    return salario;
end;  

/* Funcion anonima */
declare
  susalario employees.salary%type;
  err varchar2(50);
begin
	susalario := f_get_salary(1, err);
  if (susalario = -1) then
		dbms_output.put_line('el error es: '||err);
  else
		dbms_output.put_line('el salario del empleado 100 es: '||susalario);
  end if;
end;  
