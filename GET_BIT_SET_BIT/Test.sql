execute block
    returns (
        O_INPUT varchar(100) character set OCTETS,
        O_BIN_STR varchar(100)

             )
as
    declare variable V_INPUT varchar(100) character set OCTETS;
    declare variable C_LEN integer = 8;
    declare variable V_LEN integer = 8;
    declare variable V_POS0 integer;
    declare variable V_BIT0 smallint;
    declare variable V_POS1 integer;
    declare variable V_BIT1 smallint;
    declare variable V_CUR_BIT integer;
    declare variable V_BIT smallint;
begin
 :V_INPUT = ascii_char(bin_and(bin_shr(:V_LEN, 8), 255)) || ascii_char(bin_and(:V_LEN, 255));

  while (:V_LEN > 0) do
  begin
   :V_INPUT = :V_INPUT || ascii_char(0);
   :V_LEN = :V_LEN - 1;
  end

  :O_INPUT = :V_INPUT;

  :V_CUR_BIT = 0;

  :O_BIN_STR = '';
  while (:V_CUR_BIT < :C_LEN * 8) do
  begin
   select GET_BIT(:V_INPUT, :V_CUR_BIT) from RDB$DATABASE
   into :V_BIT;
   :O_BIN_STR = :O_BIN_STR || cast(:V_BIT as char);
   :V_CUR_BIT = :V_CUR_BIT + 1;
  end
  suspend;


  --Установим биты
  select SET_BIT(:V_INPUT, 0, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 9, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 19, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 29, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 39, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 49, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 59, 1) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 63, 1) from RDB$DATABASE into :V_INPUT;
  :O_INPUT = :V_INPUT;

  :V_CUR_BIT = 0;

  :O_BIN_STR = '';
  while (:V_CUR_BIT < :C_LEN * 8) do
  begin
   select GET_BIT(:V_INPUT, :V_CUR_BIT) from RDB$DATABASE
   into :V_BIT;
   :O_BIN_STR = :O_BIN_STR || cast(:V_BIT as char);
   :V_CUR_BIT = :V_CUR_BIT + 1;
  end
  suspend;

  --очистим биты
  select SET_BIT(:V_INPUT, 0, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 9, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 19, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 29, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 39, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 49, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 59, 0) from RDB$DATABASE into :V_INPUT;
  select SET_BIT(:V_INPUT, 63, 0) from RDB$DATABASE into :V_INPUT;
 :O_INPUT = :V_INPUT;

  :V_CUR_BIT = 0;

  :O_BIN_STR = '';
  while (:V_CUR_BIT < :C_LEN * 8) do
  begin
   select GET_BIT(:V_INPUT, :V_CUR_BIT) from RDB$DATABASE
   into :V_BIT;
   :O_BIN_STR = :O_BIN_STR || cast(:V_BIT as char);
   :V_CUR_BIT = :V_CUR_BIT + 1;
  end
  suspend;

end


