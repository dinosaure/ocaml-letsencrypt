open OUnit2

open Letsencrypt__Acme_common

let testkey_pem = "
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDjGBnd5E+TChG/
Lup5FRuYwN7RX7Ef15Yt27SKF54uWuYPaapZd8/0h5IoCluffiDxO4BL2DnOGrwQ
tDeSaOv4pXzoYAyAjpUBwaWrdCvOlMJ//fQBvv7NrCt9FoU41rUfATM9jUoecZWT
ElzzmA2TBgj1JjZEde2+WffOznAhM2t2iyoRd5oiRVgESFuE27nimneTGjpO5YuL
17qld5Z60TCaUHC1ZmU+iJvaPdPEsGSwpl+jIXJ6TfzSYeAkC6ZD8jZ+OP3z/3ua
TeKE5jgCBV0IOPXP8YKhmQblGrudsIbKizIpbINfTRmz6c2pWGgt4i9cLiedZ0kx
nquiDHJBAgMBAAECggEABaFh98xKtEe0QbAXOGYPc3m5tIl5teNFmhC30NIt1fKj
QFfTdUkpDuQjGarLE4DgLnb2EvtTEJL9XXEobRD8o8Mvnf/Oo4vVcjATzFTSprot
udhpKbdrcBxADkeGCU8aecCw/WpQv4E7rwQuKYx4LrBgPbrDLu6ZFMZ8hEQ+R7Zn
j0jWswOZEwM5xNHZ8RlwP4xsyFChvBR43lymHwDwQegd7ukbY0OcwXZ+2sxcKltr
LBZKKFPzMugKnMbZtwm3TRIUTDGjB+IZGU7dPXgF8cK4KR4yDRZ5HKIZWbqxCPCP
6TphI+Jz83OxpXU9R8rfPgUhnBgqwTdDpc5pGfmyiQKBgQD+I1TKDW5tF0fXWnza
Xwoe0ULUM8TRXWBJmxfb1OkzmNLiq/jor6zxibXOas5EzzH5zKd8/HVVBlDfgRh4
IwhfbXavIn7MMBOXg0TQjia4y9KIf2/HpdzsWaE2dpjM+wEvlOb2ea1C4/T1gSfy
miI4kWIOz/iiWcPmiADk7hMcaQKBgQDkwgupZgFS6psRYtG0yu5S2kBJyWsGo02w
kSwwZt6oEmagzF0d5JlyRss6uqbsaUzI1Ek17/m5ZEZLNoxi4abCw+kRHOoS9gWd
KumNbli1dn4m3EVc1V+b1nWAsuC8ak5QIhRFumgNyQN7W+BS6TfLn4ONmKGz6uog
njlfNdPMGQKBgFa5/ex6Cu4lnLmsQqFO/6gmp5S9GfSM1hgoWksF7JNUGtuJ7oaR
tQY0hZusrTmkL5zcr2eiy/O5FQ5BAvW0lt3iADeiIP1ThswU2v4FFMfJns5AFwhd
3Pe3WqG4dUq2eeAgA3Wnbm4+VtEVQ2myGe2OB5WgeWwGEClyzkNRz6nJAoGAPN4c
+D/6DjP6es/OeMqeS1FjVb7QSX3eSCL4nRBiIlpzEEoQZMnUwoFvxfqwO6txEObb
bAykZ930jkK/a/gaxSwXscP9zHnF2KH4bvdzhyU2P+TQV/k2bWLM9SejgL7Qg6Xt
uvf0g+Z+lK5HrAf+HqIdAOoh7JuPHIq9PUY3StECgYEAoYP7hkj8TUygnkJcHxwM
MwdqBsTdyr8O2ZjMTa/UMWlBi7kjg8KblzsRB4g/p1m2/wgyC0Yhv3VBf2le8/Rr
OfNArBggDydmCgQ0I9+IxM+IQNP17/SU5s71daxeltJOxE+PSy/WsH5TMEnQ+CMr
irbM4XSw2jtvX7qeUzcFY/E=
-----END PRIVATE KEY-----
"

let expected_protected =
  "eyJhbGciOiJSUzI1NiIsImp3ayI6eyJlIjoiQVFBQiIsImt0eSI6" ^
  "IlJTQSIsIm4iOiI0eGdaM2VSUGt3b1J2eTdxZVJVYm1NRGUwVi14" ^
  "SDllV0xkdTBpaGVlTGxybUQybXFXWGZQOUllU0tBcGJuMzRnOFR1" ^
  "QVM5ZzV6aHE4RUxRM2ttanItS1Y4NkdBTWdJNlZBY0dscTNRcnpw" ^
  "VENmXzMwQWI3LXphd3JmUmFGT05hMUh3RXpQWTFLSG5HVmt4SmM4" ^
  "NWdOa3dZSTlTWTJSSFh0dmxuM3pzNXdJVE5yZG9zcUVYZWFJa1ZZ" ^
  "QkVoYmhOdTU0cHAza3hvNlR1V0xpOWU2cFhlV2V0RXdtbEJ3dFda" ^
  "bFBvaWIyajNUeExCa3NLWmZveUZ5ZWszODBtSGdKQXVtUV9JMmZq" ^
  "ajk4Xzk3bWszaWhPWTRBZ1ZkQ0RqMXpfR0NvWmtHNVJxN25iQ0d5" ^
  "b3N5S1d5RFgwMFpzLW5OcVZob0xlSXZYQzRubldkSk1aNnJvZ3h5" ^
  "UVEifSwibm9uY2UiOiJub25jZSJ9"

let expected_payload = "eyJNc2ciOiJIZWxsbyBKV1MifQ"

let expected_signature =
  "eAGUikStX_UxyiFhxSLMyuyBcIB80GeBkFROCpap2sW3EmkU_ggF" ^
  "knaQzxrTfItICSAXsCLIquZ5BbrSWA_4vdEYrwWtdUj7NqFKjHRa" ^
  "zpLHcoR7r1rEHvkoP1xj49lS5fc3Wjjq8JUhffkhGbWZ8ZVkgPdC" ^
  "4tMBWiQDoth-x8jELP_3LYOB_ScUXi2mETBawLgOT2K8rA0Vbbmx" ^
  "hWNlOWuUf-8hL5YX4IOEwsS8JK_TrTq5Zc9My0zHJmaieqDV0UlP" ^
  "k0onFjPFkGm7MrPSgd0MqRG-4vSAg2O4hDo7rKv4n8POjjXlNQvM" ^
  "9IPLr8qZ7usYBKhEGwX3yq_eicAwBw"

let rsa_key () =
  match X509.Private_key.decode_pem (Cstruct.of_string testkey_pem) with
  | Ok `RSA skey -> skey
  | Error `Msg e -> assert_failure e

let string_member key json =
  match Yojson.Basic.Util.member key json with
  | `String s -> Ok s
  | _ -> Rresult.R.error_msgf "couldn't find string %s in %a"
           key Yojson.Basic.pp json

let json_of_string s =
  try Ok (Yojson.Basic.from_string s) with
    Yojson.Json_error str -> Error (`Msg str)

let jws_encode_somedata () =
  let priv_key = rsa_key () in
  let data  = {|{"Msg":"Hello JWS"}|} in
  let nonce = "nonce" in
  let protected = [ "jwk", Jwk.encode (`Rsa (Letsencrypt__Primitives.pub_of_priv priv_key)) ] in
  let jws = Jws.encode ~protected ~data ~nonce priv_key in
  match json_of_string jws with
  | Ok json -> json
  | Error (`Msg e) -> assert_failure e

let test_member member expected _ctx =
  let jws = jws_encode_somedata () in
  match string_member member jws with
  | Ok protected -> assert_equal protected expected
  | Error (`Msg e) -> assert_failure e

let test_encode_protected = test_member "protected" expected_protected
let test_encode_payload = test_member "payload" expected_payload
let test_encode_signature = test_member "signature" expected_signature

let test_decode_null _ctx =
  assert_equal (Jws.decode "{}") (Error (`Msg "couldn't find string protected in {}"))

let jws_decode_somedata () =
  let data = Printf.sprintf
      {|{"protected": "%s", "payload": "%s", "signature": "%s"}|}
      expected_protected expected_payload expected_signature in
  Jws.decode data

let test_decode_rsakey _ctx =
  let jws = jws_decode_somedata () in
  let key = rsa_key () in
  match jws with
  | Error (`Msg e) -> assert_failure e
  | Ok (protected, _payload) ->
    let pub = Letsencrypt__Primitives.pub_of_priv key in
    assert_equal protected.Jws.jwk (Some (`Rsa pub))

(* XXX. at this stage we probably wont the expected payload to be on some
 * global variable. *)
let test_decode_payload _ctx =
  match jws_decode_somedata () with
  | Error (`Msg e) -> assert_failure e
  | Ok (_, payload) ->
    assert_equal payload {|{"Msg":"Hello JWS"}|}


let all_tests = [
  "test_encode_protected" >:: test_encode_protected;
  "test_encode_payload" >:: test_encode_payload;
  "test_encode_signature" >:: test_encode_signature;

  "test_decode_null" >:: test_decode_null;
  "test_decode_rsakey" >:: test_decode_rsakey;
  "test_decode_payload" >:: test_decode_payload;
]
