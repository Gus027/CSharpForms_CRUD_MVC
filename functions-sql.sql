
DROP FUNCTION st_funcionarios()                        --Apagar função criada.

create or replace function st_funcionarios()           --Função Select Funcionarios
returns table
(
	cpf character varying,
	primeiro_nome character varying,
	segundo_nome character varying
)as
$$
begin
	return query
	select cpf, primeiro_nome, segundo_nome from funcionarios ORDER BY primeiro_nome;
end
$$
language plpgsql

--select * from st_funcionarios();

CREATE OR REPLACE FUNCTION row_insert_cpf(_primeiro_nome character varying, _segundo_nome character varying)
RETURNS int AS
$$
BEGIN 
	INSERT INTO funcionarios(primeiro_nome,segundo_nome)
	VALUES (_primeiro_nome, _segundo_nome);
	IF FOUND THEN
		RETURN 1; --INSERT SUCCESSFULY
	ELSE RETURN 0;  --INSERT FAIL
	END IF;
END
$$
LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION row_update_cpf (_cpf character varying, _primeiro_nome character varying, _segundo_nome character varying)
RETURNS character AS
$$
BEGIN
	UPDATE funcionarios
	SET
		primeiro_nome=_primeiro_nome,
		segundo_nome=_segundo_nome
	WHERE cpf=_cpf;
	IF FOUND THEN    --UPDATE SUCCESSFULLY 
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END
$$
LANGUAGE plpgsql



CREATE OR REPLACE FUNCTION row_delete_cpf (_cpf character varying)      --Função Deleta Tupla
RETURNS int AS
$$
BEGIN
	DELETE FROM funcionarios
	WHERE cpf = _cpf;
	IF FOUND THEN --Deleted
	   RETURN 1;
	ELSE 
		return 0;
	END IF;
END
$$
LANGUAGE plpgsql

select * from funcionarios
