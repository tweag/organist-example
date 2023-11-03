let inputs = import "./nickel.lock.ncl" in
let organist = inputs.organist in

let minio_port = 9031 in

{
  shells = organist.shells.Python310,

  shells.build = {
    packages.poetry = organist.import_nix "nixpkgs#poetry",
  },

  shells.dev = {
    env = {
      AWS_ENDPOINT_URL = "http://localhost:%{std.to_string minio_port}",
      AWS_ACCESS_KEY_ID = "minioadmin",
      AWS_SECRET_ACCESS_KEY = "minioadmin",
    },
  },

  services = {
    minio = nix-s%"
%{organist.import_nix "nixpkgs#minio"}/bin/minio server --address :%{std.to_string minio_port} ./.minio-data
    "%,
  },
}
  | (
    organist.OrganistExpression
    & organist.services.Schema
  )
