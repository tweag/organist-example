let inputs = import "./nickel.lock.ncl" in
let organist = inputs.organist in

{
  shells = organist.shells.Python310,

  shells.build = {
    packages.poetry = organist.import_nix "nixpkgs#poetry",
  },

  shells.dev = {
  },
}
  | organist.OrganistExpression
