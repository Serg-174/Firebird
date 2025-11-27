execute block
    returns (
        O_COUNT_OF_WORDS integer,
        O_INPUT varchar(4096) character set UTF8
             )
as
    declare variable V_INPUT varchar(4096) character set UTF8;
    declare variable V_DELIM char(1) character set UTF8;
    declare variable V_TWO_DELIM char(2) character set UTF8;
begin
 V_INPUT = '   Съешь же ещё                  этих мягких          французских булок да     выпей чаю  ';

 V_DELIM = ' ';
 V_TWO_DELIM = :V_DELIM||:V_DELIM;

 while (position(:V_TWO_DELIM, :V_INPUT) > 0) do
  V_INPUT =  REPLACE(:V_INPUT, :V_TWO_DELIM, :V_DELIM);

 V_INPUT = TRIM(:V_INPUT);
 O_INPUT =  :V_INPUT;
 suspend;
 select COUNT_OF_WORDS(:V_INPUT, :V_DELIM) from rdb$database
 into :O_COUNT_OF_WORDS;
 suspend;
 :V_INPUT = 'Quick brown fox jumps over back of lazy dog';
 select COUNT_OF_WORDS(:V_INPUT, :V_DELIM) from rdb$database
 into :O_COUNT_OF_WORDS;
 suspend;
end


