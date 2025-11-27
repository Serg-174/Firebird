/******************************************************************************/
/****                           Stored functions                           ****/
/******************************************************************************/



SET TERM ^ ;

CREATE FUNCTION GET_BIT (
    I_STR_VAL VARCHAR(100) CHARACTER SET OCTETS,
    I_BIT_NUM INTEGER)
RETURNS SMALLINT
AS
BEGIN
  RETURN NULL;
END^





CREATE FUNCTION SET_BIT (
    I_STR_VAL VARCHAR(100) CHARACTER SET OCTETS,
    I_BIT_NUM INTEGER,
    I_BIT_VAL SMALLINT)
RETURNS VARCHAR(100) CHARACTER SET OCTETS
AS
BEGIN
  RETURN NULL;
END^







SET TERM ; ^



/******************************************************************************/
/****                           Stored functions                           ****/
/******************************************************************************/



SET TERM ^ ;

ALTER FUNCTION GET_BIT (
    I_STR_VAL VARCHAR(100) CHARACTER SET OCTETS,
    I_BIT_NUM INTEGER)
RETURNS SMALLINT
AS
declare variable V_BYTE_IDX integer;
declare variable V_BIT_IDX integer;
declare variable V_CURR_BYTE smallint;
begin
 :V_BYTE_IDX = :I_BIT_NUM / 8 + 1;
 :V_BIT_IDX = 7 - mod(:I_BIT_NUM, 8);
 :V_CURR_BYTE = ascii_val(substring(:I_STR_VAL from :V_BYTE_IDX + 2 for 1));
 return
  bin_and(bin_shr(:V_CURR_BYTE, :V_BIT_IDX), 1);
end^


ALTER FUNCTION SET_BIT (
    I_STR_VAL VARCHAR(100) CHARACTER SET OCTETS,
    I_BIT_NUM INTEGER,
    I_BIT_VAL SMALLINT)
RETURNS VARCHAR(100) CHARACTER SET OCTETS
AS
declare variable V_DATA_LEN integer;
declare variable V_BYTE_IDX integer;
declare variable V_BIT_IDX integer;
declare variable V_CURR_BYTE smallint;
declare variable V_BITMASK smallint;
begin
 -- Проверки входных параметров (возвращем то что дали если не корректны)
 if (:I_STR_VAL is null) then
  return I_STR_VAL;
 if (:I_BIT_NUM < 0) then
  return I_STR_VAL;
 if (:I_BIT_VAL not in (0, 1)) then
  return I_STR_VAL;
 -- Первые 2 байта (big-endian) — длина полезных данных (в байтах).
 :V_DATA_LEN = (ascii_val(substring(:I_STR_VAL from 1 for 1)) * 256) +
              ascii_val(substring(:I_STR_VAL from 2 for 1));
  if (:I_BIT_NUM >= :V_DATA_LEN * 8) then
   return I_STR_VAL;
------------------------------------------------------------
  V_BYTE_IDX = 2 + (:I_BIT_NUM / 8); --Индекс байта
  V_BIT_IDX = 7 - mod(:I_BIT_NUM, 8); --Индекс бита

  V_CURR_BYTE = ascii_val(substring(:I_STR_VAL from :V_BYTE_IDX + 1 for 1));-- Нужный байт
  V_BITMASK = bin_shl(1, :V_BIT_IDX); --маска
    
  if (:I_BIT_VAL = 1) then
   V_CURR_BYTE = bin_or(:V_CURR_BYTE, :V_BITMASK);
  if (:I_BIT_VAL = 0) then
   V_CURR_BYTE = bin_and(:V_CURR_BYTE, bin_not(:V_BITMASK));

  return
    substring(:I_STR_VAL from 1 for :V_BYTE_IDX) || ascii_char(:V_CURR_BYTE) || substring(:I_STR_VAL from :V_BYTE_IDX + 2);

end

^




SET TERM ; ^



/******************************************************************************/
/****                   Function arguments descriptions                    ****/
/******************************************************************************/

COMMENT ON FUNCTION PARAMETER SET_BIT.I_BIT_NUM IS 
'номер бита (0 и далее)';

COMMENT ON FUNCTION PARAMETER SET_BIT.I_BIT_VAL IS 
'значение бита (0 или 1)
значение бита (0 или 1)';

COMMENT ON FUNCTION PARAMETER SET_BIT.I_STR_VAL IS 
'битовая строка (VARCHAR(100) CHARACTER SET OCTETS)';
