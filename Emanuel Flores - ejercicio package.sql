/*
Ejercicio 1 paquetes
Crear un paquete que contenga:
- un procedimiento que reciba por parámetros los datos del empleado y lo inserte en la BBDD
- una función que genere el id del empleado
- el procedimiento debe llamar a la función que está dentro del mismo paquete para obtener el nuevo id
- el procedimiento debe agrupar transacciones (COMMIT/ROLLBACK)

Crear un bloque anónimo que llame al procedimiento del paquete para crear un empleado

*/

create or replace package P1
is
    function next_id return number;
    procedure emple_nuevo(emple employees%rowtype);
END;
/
create or replace package body P1
is
    function next_id return number is
      id_nuevo number;
    begin
      select employees_seq.nextval into id_nuevo from dual;
      return id_nuevo;
    end;
    
    procedure emple_nuevo(emple employees%rowtype) is
      new_id number;
      
    begin
      new_id := next_id();
      insert into employees e
      values
        (new_id,
         emple.first_name,
         emple.last_name,
         emple.email,
         emple.phone_number,
         emple.hire_date,
         emple.job_id,
         emple.salary,
         emple.commission_pct,
         emple.manager_id,
         emple.department_id);
      commit;
      exception
				when others then
					rollback;   
    end;
end;

/* Bloque anonimo */
declare
  emple employees%rowtype;
begin
	emple.first_name := 'Ema';
  emple.last_name := 'Flores';
  emple.email :=  'ema@vates.com';
  emple.phone_number := '666555888';
  emple.hire_date := '14/04/2020';
  emple.job_id := 'AD_PRES';
  emple.salary := 40000;
  emple.department_id := 90;
	
  P1.emple_nuevo(emple);
end;  

/* Chequear resultados */

select * from employees;
