
.. _stdlib_json:

=========================
JSON manipulation library
=========================

.. include:: detail/json.rst

The JSON module implements JSON parser and serialization routines.
See `JHSON <www.json.org>` for details.

All functions and symbols are in "json" module, use require to get access to it. ::

    require daslib/json


++++++++++++
Type aliases
++++++++++++

.. _alias-JsValue:

.. das:attribute:: JsValue is a variant type

+-------+------------------------+
+_object+table<string;JsonValue?>+
+-------+------------------------+
+_array +array<JsonValue?>       +
+-------+------------------------+
+_string+string                  +
+-------+------------------------+
+_number+double                  +
+-------+------------------------+
+_bool  +bool                    +
+-------+------------------------+
+_null  +void?                   +
+-------+------------------------+


Single JSON element.

.. _alias-Token:

.. das:attribute:: Token is a variant type

+-------+------+
+_string+string+
+-------+------+
+_number+double+
+-------+------+
+_bool  +bool  +
+-------+------+
+_null  +void? +
+-------+------+
+_symbol+int   +
+-------+------+
+_error +string+
+-------+------+


JSON input stream token.

.. _struct-json-JsonValue:

.. das:attribute:: JsonValue



JsonValue fields are

+-----+--------------------------------+
+value+ :ref:`JsValue <alias-JsValue>` +
+-----+--------------------------------+


JSON value, wraps any JSON element.

++++++++++++++++
Value conversion
++++++++++++++++

  *  :ref:`JV (v:string const) : json::JsonValue? <function-_at_json_c__c_JV_Cs>` 
  *  :ref:`JV (v:double const) : json::JsonValue? <function-_at_json_c__c_JV_Cd>` 
  *  :ref:`JV (v:bool const) : json::JsonValue? <function-_at_json_c__c_JV_Cb>` 
  *  :ref:`JVNull () : json::JsonValue? <function-_at_json_c__c_JVNull>` 
  *  :ref:`JV (v:table\<string;json::JsonValue?\> -const) : json::JsonValue? <function-_at_json_c__c_JV_1_ls_s_gr_2_ls_1_ls_S_ls_JsonValue_gr__gr_?_gr_T>` 
  *  :ref:`JV (v:array\<json::JsonValue?\> -const) : json::JsonValue? <function-_at_json_c__c_JV_1_ls_1_ls_S_ls_JsonValue_gr__gr_?_gr_A>` 

.. _function-_at_json_c__c_JV_Cs:

.. das:function:: JV(v: string const)

JV returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+-------------+
+argument+argument type+
+========+=============+
+v       +string const +
+--------+-------------+


Creates `JsonValue` out of value.

.. _function-_at_json_c__c_JV_Cd:

.. das:function:: JV(v: double const)

JV returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+-------------+
+argument+argument type+
+========+=============+
+v       +double const +
+--------+-------------+


Creates `JsonValue` out of value.

.. _function-_at_json_c__c_JV_Cb:

.. das:function:: JV(v: bool const)

JV returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+-------------+
+argument+argument type+
+========+=============+
+v       +bool const   +
+--------+-------------+


Creates `JsonValue` out of value.

.. _function-_at_json_c__c_JVNull:

.. das:function:: JVNull()

JVNull returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

Creates `JsonValue` representing `null`.

.. _function-_at_json_c__c_JV_1_ls_s_gr_2_ls_1_ls_S_ls_JsonValue_gr__gr_?_gr_T:

.. das:function:: JV(v: table<string;json::JsonValue?>)

JV returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+---------------------------------------------------------------+
+argument+argument type                                                  +
+========+===============================================================+
+v       +table<string; :ref:`json::JsonValue <struct-json-JsonValue>` ?>+
+--------+---------------------------------------------------------------+


Creates `JsonValue` out of value.

.. _function-_at_json_c__c_JV_1_ls_1_ls_S_ls_JsonValue_gr__gr_?_gr_A:

.. das:function:: JV(v: array<json::JsonValue?>)

JV returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+--------------------------------------------------------+
+argument+argument type                                           +
+========+========================================================+
+v       +array< :ref:`json::JsonValue <struct-json-JsonValue>` ?>+
+--------+--------------------------------------------------------+


Creates `JsonValue` out of value.

++++++++++++++
Read and write
++++++++++++++

  *  :ref:`read_json (text:string const implicit;error:string& -const) : json::JsonValue? <function-_at_json_c__c_read_json_CIs_&s>` 
  *  :ref:`read_json (text:array\<uint8\> const;error:string& -const) : json::JsonValue? <function-_at_json_c__c_read_json_C1_ls_u8_gr_A_&s>` 
  *  :ref:`write_json (val:json::JsonValue? const) : string <function-_at_json_c__c_write_json_C1_ls_S_ls_JsonValue_gr__gr_?>` 

.. _function-_at_json_c__c_read_json_CIs_&s:

.. das:function:: read_json(text: string const implicit; error: string&)

read_json returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+---------------------+
+argument+argument type        +
+========+=====================+
+text    +string const implicit+
+--------+---------------------+
+error   +string&              +
+--------+---------------------+


reads JSON from the `text` string.
if `error` is not empty, it contains the parsing error message.

.. _function-_at_json_c__c_read_json_C1_ls_u8_gr_A_&s:

.. das:function:: read_json(text: array<uint8> const; error: string&)

read_json returns  :ref:`json::JsonValue <struct-json-JsonValue>` ?

+--------+------------------+
+argument+argument type     +
+========+==================+
+text    +array<uint8> const+
+--------+------------------+
+error   +string&           +
+--------+------------------+


reads JSON from the `text` string.
if `error` is not empty, it contains the parsing error message.

.. _function-_at_json_c__c_write_json_C1_ls_S_ls_JsonValue_gr__gr_?:

.. das:function:: write_json(val: json::JsonValue? const)

write_json returns string

+--------+-------------------------------------------------------+
+argument+argument type                                          +
+========+=======================================================+
+val     + :ref:`json::JsonValue <struct-json-JsonValue>` ? const+
+--------+-------------------------------------------------------+


returns JSON (textual) representation of JsonValue as a string.


