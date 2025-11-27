execute block
    returns (
        O_COUNT_OF_WORDS integer

             )
as
    declare variable V_INPUT varchar(4096) character set UTF8;
begin
 :V_INPUT = 'Съешь же ещё этих мягких французских булок да выпей чаю';
 select COUNT_OF_WORDS(:V_INPUT, ' ') from rdb$database
 into :O_COUNT_OF_WORDS;
 suspend;
 :V_INPUT = 'Quick brown fox jumps over back of lazy dog';
 select COUNT_OF_WORDS(:V_INPUT, ' ') from rdb$database
 into :O_COUNT_OF_WORDS;
 suspend;
end


