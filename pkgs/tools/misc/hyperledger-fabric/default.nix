{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "hyperledger-fabric";
  version = "2.3.0";

  goPackagePath = "github.com/hyperledger/fabric";

  # taken from https://github.com/hyperledger/fabric/blob/v1.3.0/Makefile#L108
  subPackages = [
    "cmd/configtxgen"
    "cmd/configtxlator"
    "cmd/cryptogen"
    "cmd/idemixgen"
    "cmd/discover"
    "cmd/peer"
    "cmd/orderer"
    "cmd/osnadmin"
  ];

  src = fetchFromGitHub {
    owner = "hyperledger";
    repo = "fabric";
    rev = "v${version}";
    sha256 = "02lm3abysdx20m2i15fjwhf0xw8daf49pakwmpqpphbkpcyyslk0";
  };

  doCheck = true;

  meta = with stdenv.lib; {
    description = "An implementation of blockchain technology, leveraging familiar and proven technologies";
    homepage = "https://wiki.hyperledger.org/projects/Fabric";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
