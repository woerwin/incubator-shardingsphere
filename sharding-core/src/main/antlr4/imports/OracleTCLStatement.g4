grammar OracleTCLStatement;

import OracleKeyword, Keyword, Symbol, OracleBase, DataType;

setTransaction
    : SET TRANSACTION
    (
        READ (ONLY | WRITE)
        | ISOLATION LEVEL (SERIALIZABLE | READ COMMITTED)
        | USE ROLLBACK SEGMENT ID
    )?
    | NAME STRING_
    ;
    
commit
    : COMMIT WORK?
    (
        (COMMENT STRING_)?
        | (WRITE (WAIT | NOWAIT)? (IMMEDIATE | BATCH)?)?
        | FORCE STRING_ (COMMA_ NUMBER_)?
    )
    ;
    
rollback
    : ROLLBACK WORK?
    (
        TO SAVEPOINT? ID
        | FORCE STRING_
    )? 
    ;
    
savepoint
    : SAVEPOINT ID 
    ;
