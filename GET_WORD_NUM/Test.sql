execute block
    returns (
        O_WORD varchar(4096) character set UTF8,
        O_INPUT varchar(4096) character set UTF8
             )
as
    declare variable V_INPUT varchar(4096) character set UTF8;
    declare variable V_NUM integer = 3;
    declare variable V_DELIM char(1) character set UTF8;
    declare variable V_TWO_DELIM char(2) character set UTF8;
begin
 :V_INPUT = '   Съешь же ещё этих    мягких          французских булок да     выпей чаю  ';

 :V_DELIM = ' ';
 :V_TWO_DELIM = :V_DELIM||:V_DELIM;

 while (position(:V_TWO_DELIM, :V_INPUT) > 0) do
  :V_INPUT =  REPLACE(:V_INPUT, :V_TWO_DELIM, :V_DELIM);

 :V_INPUT = TRIM(:V_INPUT);
 :O_INPUT =  :V_INPUT;



 select GET_WORD_NUM(:V_INPUT, :V_DELIM, :V_NUM) from rdb$database
 into :O_WORD;
 suspend;

end


