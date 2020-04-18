/*
Ejercicio 1 procedimientos
crear un procedimiento que reciba por parámetros los datos del empleado y lo inserte en la BBDD
El procedimiento debe tener una función interna que genere el id del mismo)
*/

/* Respuesta al ejercicio - Emanuel Flores */

/* Procedimiento */
create or replace procedure nuevo_emple(emple employees%rowtype) is
  new_id number;
  
  /* Funcion interna */
  function genera_id return number is
    id_nuevo number;
  begin
    select employees_seq.nextval into id_nuevo from dual;
    return id_nuevo;
  end;
begin
	new_id := genera_id();
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
end;

/* Llamado a procedimiento en bloque anonimo*/
declare
  emple employees%rowtype;
begin
	emple.first_name := 'Juan';
  emple.last_name := 'Gomez';
  emple.email :=  'juan@juan.com';
  emple.phone_number := '123123123';
  emple.hire_date := '08/04/2020';
  emple.job_id := 'AD_PRES';
  emple.salary := 40000;
  emple.department_id := 90;
  
  nuevo_emple(emple);
end;  

/* Chequeo de resultados */
select * from employees;
