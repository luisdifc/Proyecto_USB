/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 5.4.0-6ubuntu1~16.04.4 -O2 -fstack-protector-strong -fPIC -Os) */

(* src = "Tx.v:1" *)
module Tx(CLK, TRANSMIT, TRANSMIT_BYTE_COUNT, TRANSMIT_HEADER_LOW, TRANSMIT_HEADER_HIGH, TRANSMIT_DATA_OUTPUT, GoodCRC_Response, ALERT, ALERTo, TX_BUF_HEADER_BYTE_1, RX_BUF_HEADER_BYTE_1, RX_BUF_FRAME_TYPE, reset);
  (* src = "Tx.v:174" *)
  wire [15:0] _000_;
  (* src = "Tx.v:174" *)
  wire [3:0] _001_;
  (* src = "Tx.v:54" *)
  wire [3:0] _002_;
  (* src = "Tx.v:54" *)
  wire [3:0] _003_;
  (* src = "Tx.v:54" *)
  wire [3:0] _004_;
  (* src = "Tx.v:54" *)
  wire [3:0] _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  wire _128_;
  wire _129_;
  wire _130_;
  wire _131_;
  wire _132_;
  wire _133_;
  wire _134_;
  wire _135_;
  wire _136_;
  wire _137_;
  wire _138_;
  wire _139_;
  wire _140_;
  wire _141_;
  wire _142_;
  wire _143_;
  wire _144_;
  wire _145_;
  wire _146_;
  wire _147_;
  wire _148_;
  wire _149_;
  wire _150_;
  wire _151_;
  wire _152_;
  wire _153_;
  wire _154_;
  wire _155_;
  wire _156_;
  wire _157_;
  wire _158_;
  wire _159_;
  wire _160_;
  wire _161_;
  wire _162_;
  wire _163_;
  wire _164_;
  wire _165_;
  wire _166_;
  wire _167_;
  wire _168_;
  wire _169_;
  wire _170_;
  wire _171_;
  wire _172_;
  wire _173_;
  wire _174_;
  wire _175_;
  wire _176_;
  wire _177_;
  wire _178_;
  wire _179_;
  wire _180_;
  wire _181_;
  wire _182_;
  wire _183_;
  wire _184_;
  wire _185_;
  wire _186_;
  wire _187_;
  wire _188_;
  wire _189_;
  wire _190_;
  wire _191_;
  wire _192_;
  wire _193_;
  wire _194_;
  wire _195_;
  wire _196_;
  wire _197_;
  wire _198_;
  wire _199_;
  wire _200_;
  wire _201_;
  wire _202_;
  wire _203_;
  wire _204_;
  wire _205_;
  wire _206_;
  wire _207_;
  wire _208_;
  wire _209_;
  wire _210_;
  wire _211_;
  wire _212_;
  wire _213_;
  wire _214_;
  wire _215_;
  wire _216_;
  wire _217_;
  wire _218_;
  wire _219_;
  wire _220_;
  wire _221_;
  wire _222_;
  wire _223_;
  wire _224_;
  wire _225_;
  wire _226_;
  wire _227_;
  wire _228_;
  wire _229_;
  wire _230_;
  wire _231_;
  wire _232_;
  wire _233_;
  wire _234_;
  wire _235_;
  wire _236_;
  wire _237_;
  wire _238_;
  wire _239_;
  wire _240_;
  wire _241_;
  wire _242_;
  wire _243_;
  wire _244_;
  wire _245_;
  wire _246_;
  wire _247_;
  wire _248_;
  wire _249_;
  wire _250_;
  wire _251_;
  wire _252_;
  wire _253_;
  wire _254_;
  wire _255_;
  wire _256_;
  wire _257_;
  wire _258_;
  wire _259_;
  wire _260_;
  wire _261_;
  wire _262_;
  wire _263_;
  wire _264_;
  wire _265_;
  wire _266_;
  wire _267_;
  wire _268_;
  wire _269_;
  wire _270_;
  wire _271_;
  wire _272_;
  wire _273_;
  wire _274_;
  wire _275_;
  wire _276_;
  wire _277_;
  wire _278_;
  wire _279_;
  wire _280_;
  wire _281_;
  wire _282_;
  wire _283_;
  wire _284_;
  wire _285_;
  wire _286_;
  wire _287_;
  wire _288_;
  wire _289_;
  wire _290_;
  wire _291_;
  wire _292_;
  wire _293_;
  wire _294_;
  wire [3:0] _295_;
  wire [1:0] _296_;
  wire [3:0] _297_;
  wire [1:0] _298_;
  wire [1:0] _299_;
  wire [1:0] _300_;
  wire [1:0] _301_;
  wire [1:0] _302_;
  wire [1:0] _303_;
  wire _304_;
  wire [1:0] _305_;
  wire [1:0] _306_;
  wire [1:0] _307_;
  wire _308_;
  wire [1:0] _309_;
  wire _310_;
  wire [7:0] _311_;
  wire [7:0] _312_;
  wire [3:0] _313_;
  wire [3:0] _314_;
  wire [3:0] _315_;
  (* src = "Tx.v:122" *)
  wire _316_;
  (* src = "Tx.v:122" *)
  wire _317_;
  wire _318_;
  (* src = "Tx.v:59|<techmap.v>:432" *)
  wire [19:0] _319_;
  (* src = "Tx.v:59|<techmap.v>:428" *)
  wire [3:0] _320_;
  wire _321_;
  wire _322_;
  wire _323_;
  (* src = "<techmap.v>:260|<techmap.v>:203" *)
  wire [2:0] _324_;
  wire [2:0] _325_;
  wire _326_;
  wire _327_;
  (* src = "Tx.v:59|<techmap.v>:445" *)
  wire _328_;
  (* src = "Tx.v:5" *)
  input [15:0] ALERT;
  (* src = "Tx.v:16" *)
  output [15:0] ALERTo;
  (* src = "Tx.v:9" *)
  input CLK;
  (* src = "Tx.v:8" *)
  input GoodCRC_Response;
  (* src = "Tx.v:6" *)
  input [7:0] RX_BUF_FRAME_TYPE;
  (* src = "Tx.v:6" *)
  input [7:0] RX_BUF_HEADER_BYTE_1;
  (* src = "Tx.v:5" *)
  input [15:0] TRANSMIT;
  (* src = "Tx.v:6" *)
  input [7:0] TRANSMIT_BYTE_COUNT;
  (* src = "Tx.v:45" *)
  output [7:0] TRANSMIT_DATA_OUTPUT;
  (* src = "Tx.v:6" *)
  input [7:0] TRANSMIT_HEADER_HIGH;
  (* src = "Tx.v:6" *)
  input [7:0] TRANSMIT_HEADER_LOW;
  (* src = "Tx.v:6" *)
  input [7:0] TX_BUF_HEADER_BYTE_1;
  (* src = "Tx.v:30" *)
  wire [3:0] estado_actual;
  (* src = "Tx.v:31" *)
  wire [3:0] proximo_estado;
  (* src = "Tx.v:9" *)
  input reset;
  NOT _329_ (
    .A(_254_),
    .Y(_271_)
  );
  NOR _330_ (
    .A(_255_),
    .B(_271_),
    .Y(_256_)
  );
  NOT _331_ (
    .A(_257_),
    .Y(_274_)
  );
  NOR _332_ (
    .A(_274_),
    .B(_255_),
    .Y(_258_)
  );
  NOT _333_ (
    .A(_259_),
    .Y(_008_)
  );
  NOR _334_ (
    .A(_008_),
    .B(_255_),
    .Y(_260_)
  );
  NOT _335_ (
    .A(_261_),
    .Y(_011_)
  );
  NOR _336_ (
    .A(_011_),
    .B(_255_),
    .Y(_262_)
  );
  NAND _337_ (
    .A(_264_),
    .B(_255_),
    .Y(_014_)
  );
  NOT _338_ (
    .A(_255_),
    .Y(_016_)
  );
  NAND _339_ (
    .A(_263_),
    .B(_016_),
    .Y(_018_)
  );
  NAND _340_ (
    .A(_018_),
    .B(_014_),
    .Y(_265_)
  );
  NAND _341_ (
    .A(_267_),
    .B(_255_),
    .Y(_021_)
  );
  NAND _342_ (
    .A(_266_),
    .B(_016_),
    .Y(_023_)
  );
  NAND _343_ (
    .A(_023_),
    .B(_021_),
    .Y(_268_)
  );
  NAND _344_ (
    .A(_270_),
    .B(_255_),
    .Y(_026_)
  );
  NAND _345_ (
    .A(_269_),
    .B(_016_),
    .Y(_028_)
  );
  NAND _346_ (
    .A(_028_),
    .B(_026_),
    .Y(_272_)
  );
  NAND _347_ (
    .A(_006_),
    .B(_255_),
    .Y(_031_)
  );
  NAND _348_ (
    .A(_273_),
    .B(_016_),
    .Y(_033_)
  );
  NAND _349_ (
    .A(_033_),
    .B(_031_),
    .Y(_007_)
  );
  NAND _350_ (
    .A(_010_),
    .B(_255_),
    .Y(_036_)
  );
  NAND _351_ (
    .A(_009_),
    .B(_016_),
    .Y(_038_)
  );
  NAND _352_ (
    .A(_038_),
    .B(_036_),
    .Y(_012_)
  );
  NAND _353_ (
    .A(_015_),
    .B(_255_),
    .Y(_041_)
  );
  NAND _354_ (
    .A(_013_),
    .B(_016_),
    .Y(_043_)
  );
  NAND _355_ (
    .A(_043_),
    .B(_041_),
    .Y(_017_)
  );
  NAND _356_ (
    .A(_020_),
    .B(_255_),
    .Y(_046_)
  );
  NAND _357_ (
    .A(_019_),
    .B(_016_),
    .Y(_048_)
  );
  NAND _358_ (
    .A(_048_),
    .B(_046_),
    .Y(_022_)
  );
  NAND _359_ (
    .A(_025_),
    .B(_255_),
    .Y(_051_)
  );
  NAND _360_ (
    .A(_024_),
    .B(_016_),
    .Y(_053_)
  );
  NAND _361_ (
    .A(_053_),
    .B(_051_),
    .Y(_027_)
  );
  NAND _362_ (
    .A(_030_),
    .B(_255_),
    .Y(_056_)
  );
  NAND _363_ (
    .A(_029_),
    .B(_016_),
    .Y(_058_)
  );
  NAND _364_ (
    .A(_058_),
    .B(_056_),
    .Y(_032_)
  );
  NAND _365_ (
    .A(_035_),
    .B(_255_),
    .Y(_061_)
  );
  NAND _366_ (
    .A(_034_),
    .B(_016_),
    .Y(_063_)
  );
  NAND _367_ (
    .A(_063_),
    .B(_061_),
    .Y(_037_)
  );
  NAND _368_ (
    .A(_040_),
    .B(_255_),
    .Y(_066_)
  );
  NAND _369_ (
    .A(_039_),
    .B(_016_),
    .Y(_068_)
  );
  NAND _370_ (
    .A(_068_),
    .B(_066_),
    .Y(_042_)
  );
  NAND _371_ (
    .A(_045_),
    .B(_255_),
    .Y(_070_)
  );
  NAND _372_ (
    .A(_044_),
    .B(_016_),
    .Y(_071_)
  );
  NAND _373_ (
    .A(_071_),
    .B(_070_),
    .Y(_047_)
  );
  NAND _374_ (
    .A(_050_),
    .B(_255_),
    .Y(_074_)
  );
  NAND _375_ (
    .A(_049_),
    .B(_016_),
    .Y(_076_)
  );
  NAND _376_ (
    .A(_076_),
    .B(_074_),
    .Y(_052_)
  );
  NAND _377_ (
    .A(_055_),
    .B(_255_),
    .Y(_079_)
  );
  NAND _378_ (
    .A(_054_),
    .B(_016_),
    .Y(_081_)
  );
  NAND _379_ (
    .A(_081_),
    .B(_079_),
    .Y(_057_)
  );
  NAND _380_ (
    .A(_060_),
    .B(_255_),
    .Y(_083_)
  );
  NAND _381_ (
    .A(_059_),
    .B(_016_),
    .Y(_084_)
  );
  NAND _382_ (
    .A(_084_),
    .B(_083_),
    .Y(_062_)
  );
  NAND _383_ (
    .A(_065_),
    .B(_255_),
    .Y(_087_)
  );
  NAND _384_ (
    .A(_064_),
    .B(_016_),
    .Y(_089_)
  );
  NAND _385_ (
    .A(_089_),
    .B(_087_),
    .Y(_067_)
  );
  NOT _386_ (
    .A(_252_),
    .Y(_092_)
  );
  NOR _387_ (
    .A(_092_),
    .B(_250_),
    .Y(_094_)
  );
  NOT _388_ (
    .A(_249_),
    .Y(_096_)
  );
  NOR _389_ (
    .A(_251_),
    .B(_096_),
    .Y(_098_)
  );
  NAND _390_ (
    .A(_098_),
    .B(_094_),
    .Y(_100_)
  );
  NOT _391_ (
    .A(_095_),
    .Y(_102_)
  );
  NAND _392_ (
    .A(_097_),
    .B(_102_),
    .Y(_104_)
  );
  NOT _393_ (
    .A(_253_),
    .Y(_106_)
  );
  NOR _394_ (
    .A(_123_),
    .B(_106_),
    .Y(_108_)
  );
  NOT _395_ (
    .A(_121_),
    .Y(_110_)
  );
  NOR _396_ (
    .A(_110_),
    .B(_119_),
    .Y(_112_)
  );
  NOR _397_ (
    .A(_112_),
    .B(_108_),
    .Y(_114_)
  );
  NAND _398_ (
    .A(_114_),
    .B(_104_),
    .Y(_116_)
  );
  NOT _399_ (
    .A(_115_),
    .Y(_118_)
  );
  NOT _400_ (
    .A(_117_),
    .Y(_120_)
  );
  NAND _401_ (
    .A(_120_),
    .B(_118_),
    .Y(_122_)
  );
  NAND _402_ (
    .A(_117_),
    .B(_115_),
    .Y(_124_)
  );
  NAND _403_ (
    .A(_124_),
    .B(_122_),
    .Y(_125_)
  );
  NOT _404_ (
    .A(_123_),
    .Y(_126_)
  );
  NOR _405_ (
    .A(_126_),
    .B(_253_),
    .Y(_127_)
  );
  NOT _406_ (
    .A(_113_),
    .Y(_128_)
  );
  NOR _407_ (
    .A(_128_),
    .B(_111_),
    .Y(_129_)
  );
  NOR _408_ (
    .A(_129_),
    .B(_127_),
    .Y(_130_)
  );
  NAND _409_ (
    .A(_130_),
    .B(_125_),
    .Y(_131_)
  );
  NOR _410_ (
    .A(_131_),
    .B(_116_),
    .Y(_132_)
  );
  NOT _411_ (
    .A(_099_),
    .Y(_133_)
  );
  NOT _412_ (
    .A(_101_),
    .Y(_134_)
  );
  NAND _413_ (
    .A(_134_),
    .B(_133_),
    .Y(_135_)
  );
  NAND _414_ (
    .A(_101_),
    .B(_099_),
    .Y(_136_)
  );
  NAND _415_ (
    .A(_136_),
    .B(_135_),
    .Y(_137_)
  );
  NOT _416_ (
    .A(_144_),
    .Y(_138_)
  );
  NOT _417_ (
    .A(_165_),
    .Y(_139_)
  );
  NAND _418_ (
    .A(_139_),
    .B(_138_),
    .Y(_140_)
  );
  NOT _419_ (
    .A(_111_),
    .Y(_141_)
  );
  NOR _420_ (
    .A(_113_),
    .B(_141_),
    .Y(_142_)
  );
  NOR _421_ (
    .A(_142_),
    .B(_140_),
    .Y(_143_)
  );
  NAND _422_ (
    .A(_143_),
    .B(_137_),
    .Y(_145_)
  );
  NOT _423_ (
    .A(_091_),
    .Y(_146_)
  );
  NOT _424_ (
    .A(_093_),
    .Y(_147_)
  );
  NAND _425_ (
    .A(_147_),
    .B(_146_),
    .Y(_148_)
  );
  NAND _426_ (
    .A(_093_),
    .B(_091_),
    .Y(_149_)
  );
  NAND _427_ (
    .A(_149_),
    .B(_148_),
    .Y(_150_)
  );
  NOT _428_ (
    .A(_176_),
    .Y(_151_)
  );
  NOT _429_ (
    .A(_197_),
    .Y(_152_)
  );
  NAND _430_ (
    .A(_152_),
    .B(_151_),
    .Y(_153_)
  );
  NOR _431_ (
    .A(_153_),
    .B(_207_),
    .Y(_154_)
  );
  NAND _432_ (
    .A(_154_),
    .B(_150_),
    .Y(_155_)
  );
  NOR _433_ (
    .A(_155_),
    .B(_145_),
    .Y(_156_)
  );
  NAND _434_ (
    .A(_156_),
    .B(_132_),
    .Y(_157_)
  );
  NAND _435_ (
    .A(_110_),
    .B(_119_),
    .Y(_158_)
  );
  NOT _436_ (
    .A(_105_),
    .Y(_159_)
  );
  NAND _437_ (
    .A(_159_),
    .B(_103_),
    .Y(_160_)
  );
  NAND _438_ (
    .A(_160_),
    .B(_158_),
    .Y(_161_)
  );
  NOT _439_ (
    .A(_088_),
    .Y(_162_)
  );
  NAND _440_ (
    .A(_090_),
    .B(_162_),
    .Y(_163_)
  );
  NOT _441_ (
    .A(_103_),
    .Y(_164_)
  );
  NAND _442_ (
    .A(_105_),
    .B(_164_),
    .Y(_166_)
  );
  NAND _443_ (
    .A(_166_),
    .B(_163_),
    .Y(_167_)
  );
  NOR _444_ (
    .A(_167_),
    .B(_161_),
    .Y(_168_)
  );
  NOR _445_ (
    .A(_109_),
    .B(_107_),
    .Y(_169_)
  );
  NOT _446_ (
    .A(_107_),
    .Y(_170_)
  );
  NOT _447_ (
    .A(_109_),
    .Y(_171_)
  );
  NOR _448_ (
    .A(_171_),
    .B(_170_),
    .Y(_172_)
  );
  NOR _449_ (
    .A(_172_),
    .B(_169_),
    .Y(_173_)
  );
  NOT _450_ (
    .A(_085_),
    .Y(_174_)
  );
  NOR _451_ (
    .A(_086_),
    .B(_174_),
    .Y(_175_)
  );
  NOT _452_ (
    .A(_086_),
    .Y(_177_)
  );
  NOR _453_ (
    .A(_177_),
    .B(_085_),
    .Y(_178_)
  );
  NOR _454_ (
    .A(_178_),
    .B(_175_),
    .Y(_179_)
  );
  NOR _455_ (
    .A(_097_),
    .B(_102_),
    .Y(_180_)
  );
  NOR _456_ (
    .A(_090_),
    .B(_162_),
    .Y(_181_)
  );
  NOR _457_ (
    .A(_181_),
    .B(_180_),
    .Y(_182_)
  );
  NAND _458_ (
    .A(_182_),
    .B(_179_),
    .Y(_183_)
  );
  NOR _459_ (
    .A(_183_),
    .B(_173_),
    .Y(_184_)
  );
  NAND _460_ (
    .A(_184_),
    .B(_168_),
    .Y(_185_)
  );
  NOR _461_ (
    .A(_185_),
    .B(_157_),
    .Y(_186_)
  );
  NOR _462_ (
    .A(_186_),
    .B(_100_),
    .Y(_187_)
  );
  NOR _463_ (
    .A(_251_),
    .B(_249_),
    .Y(_188_)
  );
  NOT _464_ (
    .A(_188_),
    .Y(_189_)
  );
  NOR _465_ (
    .A(_189_),
    .B(_092_),
    .Y(_190_)
  );
  NOT _466_ (
    .A(_190_),
    .Y(_191_)
  );
  NAND _467_ (
    .A(_251_),
    .B(_249_),
    .Y(_192_)
  );
  NOR _468_ (
    .A(_192_),
    .B(_252_),
    .Y(_193_)
  );
  NOR _469_ (
    .A(_193_),
    .B(_250_),
    .Y(_194_)
  );
  NAND _470_ (
    .A(_194_),
    .B(_189_),
    .Y(_195_)
  );
  NAND _471_ (
    .A(_195_),
    .B(_191_),
    .Y(_196_)
  );
  NAND _472_ (
    .A(_190_),
    .B(_250_),
    .Y(_198_)
  );
  NOT _473_ (
    .A(_192_),
    .Y(_199_)
  );
  NAND _474_ (
    .A(_199_),
    .B(_094_),
    .Y(_200_)
  );
  NAND _475_ (
    .A(_200_),
    .B(_198_),
    .Y(_201_)
  );
  NOT _476_ (
    .A(_094_),
    .Y(_202_)
  );
  NOR _477_ (
    .A(_202_),
    .B(_249_),
    .Y(_073_)
  );
  NOR _478_ (
    .A(_073_),
    .B(_201_),
    .Y(_203_)
  );
  NAND _479_ (
    .A(_203_),
    .B(_196_),
    .Y(_204_)
  );
  NOR _480_ (
    .A(_204_),
    .B(_187_),
    .Y(_205_)
  );
  NAND _481_ (
    .A(_119_),
    .B(_253_),
    .Y(_206_)
  );
  NOR _482_ (
    .A(_206_),
    .B(_196_),
    .Y(_208_)
  );
  NOR _483_ (
    .A(_208_),
    .B(_205_),
    .Y(_072_)
  );
  NOT _484_ (
    .A(_100_),
    .Y(_209_)
  );
  NOR _485_ (
    .A(_101_),
    .B(_099_),
    .Y(_210_)
  );
  NOT _486_ (
    .A(_136_),
    .Y(_211_)
  );
  NOR _487_ (
    .A(_211_),
    .B(_210_),
    .Y(_212_)
  );
  NOR _488_ (
    .A(_142_),
    .B(_212_),
    .Y(_213_)
  );
  NOR _489_ (
    .A(_197_),
    .B(_165_),
    .Y(_214_)
  );
  NAND _490_ (
    .A(_214_),
    .B(_138_),
    .Y(_215_)
  );
  NOR _491_ (
    .A(_215_),
    .B(_173_),
    .Y(_216_)
  );
  NAND _492_ (
    .A(_216_),
    .B(_213_),
    .Y(_217_)
  );
  NOT _493_ (
    .A(_090_),
    .Y(_218_)
  );
  NAND _494_ (
    .A(_218_),
    .B(_088_),
    .Y(_219_)
  );
  NAND _495_ (
    .A(_179_),
    .B(_219_),
    .Y(_220_)
  );
  NOR _496_ (
    .A(_159_),
    .B(_103_),
    .Y(_221_)
  );
  NOR _497_ (
    .A(_221_),
    .B(_180_),
    .Y(_222_)
  );
  NAND _498_ (
    .A(_222_),
    .B(_125_),
    .Y(_223_)
  );
  NOR _499_ (
    .A(_223_),
    .B(_220_),
    .Y(_224_)
  );
  NAND _500_ (
    .A(_224_),
    .B(_150_),
    .Y(_225_)
  );
  NOR _501_ (
    .A(_225_),
    .B(_217_),
    .Y(_226_)
  );
  NOT _502_ (
    .A(_207_),
    .Y(_227_)
  );
  NAND _503_ (
    .A(_227_),
    .B(_151_),
    .Y(_228_)
  );
  NOT _504_ (
    .A(_119_),
    .Y(_229_)
  );
  NOR _505_ (
    .A(_121_),
    .B(_229_),
    .Y(_230_)
  );
  NOR _506_ (
    .A(_105_),
    .B(_164_),
    .Y(_231_)
  );
  NOR _507_ (
    .A(_231_),
    .B(_230_),
    .Y(_232_)
  );
  NAND _508_ (
    .A(_232_),
    .B(_130_),
    .Y(_233_)
  );
  NOR _509_ (
    .A(_233_),
    .B(_116_),
    .Y(_234_)
  );
  NAND _510_ (
    .A(_234_),
    .B(_163_),
    .Y(_235_)
  );
  NOR _511_ (
    .A(_235_),
    .B(_228_),
    .Y(_236_)
  );
  NAND _512_ (
    .A(_236_),
    .B(_226_),
    .Y(_237_)
  );
  NAND _513_ (
    .A(_237_),
    .B(_209_),
    .Y(_238_)
  );
  NOT _514_ (
    .A(_198_),
    .Y(_239_)
  );
  NOR _515_ (
    .A(_200_),
    .B(_069_),
    .Y(_240_)
  );
  NOR _516_ (
    .A(_240_),
    .B(_239_),
    .Y(_241_)
  );
  NAND _517_ (
    .A(_241_),
    .B(_238_),
    .Y(_075_)
  );
  NOT _518_ (
    .A(_201_),
    .Y(_242_)
  );
  NAND _519_ (
    .A(_186_),
    .B(_209_),
    .Y(_243_)
  );
  NAND _520_ (
    .A(_243_),
    .B(_242_),
    .Y(_077_)
  );
  NOT _521_ (
    .A(_250_),
    .Y(_244_)
  );
  NAND _522_ (
    .A(_092_),
    .B(_244_),
    .Y(_245_)
  );
  NAND _523_ (
    .A(_251_),
    .B(_096_),
    .Y(_246_)
  );
  NOR _524_ (
    .A(_246_),
    .B(_245_),
    .Y(_078_)
  );
  NOT _525_ (
    .A(_098_),
    .Y(_247_)
  );
  NOR _526_ (
    .A(_245_),
    .B(_247_),
    .Y(_080_)
  );
  NOT _527_ (
    .A(_194_),
    .Y(_248_)
  );
  NAND _528_ (
    .A(_248_),
    .B(_191_),
    .Y(_082_)
  );
  DFF _529_ (
    .C(CLK),
    .D(_000_[0]),
    .Q(ALERTo[0])
  );
  DFF _530_ (
    .C(CLK),
    .D(_000_[1]),
    .Q(ALERTo[1])
  );
  DFF _531_ (
    .C(CLK),
    .D(_000_[2]),
    .Q(ALERTo[2])
  );
  DFF _532_ (
    .C(CLK),
    .D(_000_[3]),
    .Q(ALERTo[3])
  );
  DFF _533_ (
    .C(CLK),
    .D(_000_[4]),
    .Q(ALERTo[4])
  );
  DFF _534_ (
    .C(CLK),
    .D(_000_[5]),
    .Q(ALERTo[5])
  );
  DFF _535_ (
    .C(CLK),
    .D(_000_[6]),
    .Q(ALERTo[6])
  );
  DFF _536_ (
    .C(CLK),
    .D(_000_[7]),
    .Q(ALERTo[7])
  );
  DFF _537_ (
    .C(CLK),
    .D(_000_[8]),
    .Q(ALERTo[8])
  );
  DFF _538_ (
    .C(CLK),
    .D(_000_[9]),
    .Q(ALERTo[9])
  );
  DFF _539_ (
    .C(CLK),
    .D(_000_[10]),
    .Q(ALERTo[10])
  );
  DFF _540_ (
    .C(CLK),
    .D(_000_[11]),
    .Q(ALERTo[11])
  );
  DFF _541_ (
    .C(CLK),
    .D(_000_[12]),
    .Q(ALERTo[12])
  );
  DFF _542_ (
    .C(CLK),
    .D(_000_[13]),
    .Q(ALERTo[13])
  );
  DFF _543_ (
    .C(CLK),
    .D(_000_[14]),
    .Q(ALERTo[14])
  );
  DFF _544_ (
    .C(CLK),
    .D(_000_[15]),
    .Q(ALERTo[15])
  );
  DFF _545_ (
    .C(CLK),
    .D(_001_[0]),
    .Q(estado_actual[0])
  );
  DFF _546_ (
    .C(CLK),
    .D(_001_[1]),
    .Q(estado_actual[1])
  );
  DFF _547_ (
    .C(CLK),
    .D(_001_[2]),
    .Q(estado_actual[2])
  );
  DFF _548_ (
    .C(CLK),
    .D(_001_[3]),
    .Q(estado_actual[3])
  );
  \$_DLATCH_P_  _549_ (
    .D(1'b1),
    .E(_278_),
    .Q(ALERTo[4])
  );
  \$_DLATCH_P_  _550_ (
    .D(1'b1),
    .E(_280_),
    .Q(ALERTo[6])
  );
  \$_DLATCH_P_  _551_ (
    .D(_002_[0]),
    .E(_287_),
    .Q(proximo_estado[0])
  );
  \$_DLATCH_P_  _552_ (
    .D(_002_[1]),
    .E(_287_),
    .Q(proximo_estado[1])
  );
  \$_DLATCH_P_  _553_ (
    .D(_002_[2]),
    .E(_287_),
    .Q(proximo_estado[2])
  );
  \$_DLATCH_P_  _554_ (
    .D(_002_[3]),
    .E(_287_),
    .Q(proximo_estado[3])
  );
  assign TRANSMIT_DATA_OUTPUT = 8'b00000000;
  assign _144_ = RX_BUF_FRAME_TYPE[3];
  assign _165_ = RX_BUF_FRAME_TYPE[4];
  assign _176_ = RX_BUF_FRAME_TYPE[5];
  assign _197_ = RX_BUF_FRAME_TYPE[6];
  assign _207_ = RX_BUF_FRAME_TYPE[7];
  assign _249_ = estado_actual[3];
  assign _250_ = estado_actual[1];
  assign _251_ = estado_actual[2];
  assign _252_ = estado_actual[0];
  assign _253_ = TRANSMIT[2];
  assign _254_ = proximo_estado[0];
  assign _255_ = reset;
  assign _001_[0] = _256_;
  assign _257_ = proximo_estado[1];
  assign _001_[1] = _258_;
  assign _259_ = proximo_estado[2];
  assign _001_[2] = _260_;
  assign _261_ = proximo_estado[3];
  assign _001_[3] = _262_;
  assign _263_ = ALERTo[0];
  assign _264_ = ALERT[0];
  assign _000_[0] = _265_;
  assign _266_ = ALERTo[1];
  assign _267_ = ALERT[1];
  assign _000_[1] = _268_;
  assign _269_ = ALERTo[2];
  assign _270_ = ALERT[2];
  assign _000_[2] = _272_;
  assign _273_ = ALERTo[3];
  assign _006_ = ALERT[3];
  assign _000_[3] = _007_;
  assign _009_ = ALERTo[4];
  assign _010_ = ALERT[4];
  assign _000_[4] = _012_;
  assign _013_ = ALERTo[5];
  assign _015_ = ALERT[5];
  assign _000_[5] = _017_;
  assign _019_ = ALERTo[6];
  assign _020_ = ALERT[6];
  assign _000_[6] = _022_;
  assign _024_ = ALERTo[7];
  assign _025_ = ALERT[7];
  assign _000_[7] = _027_;
  assign _029_ = ALERTo[8];
  assign _030_ = ALERT[8];
  assign _000_[8] = _032_;
  assign _034_ = ALERTo[9];
  assign _035_ = ALERT[9];
  assign _000_[9] = _037_;
  assign _039_ = ALERTo[10];
  assign _040_ = ALERT[10];
  assign _000_[10] = _042_;
  assign _044_ = ALERTo[11];
  assign _045_ = ALERT[11];
  assign _000_[11] = _047_;
  assign _049_ = ALERTo[12];
  assign _050_ = ALERT[12];
  assign _000_[12] = _052_;
  assign _054_ = ALERTo[13];
  assign _055_ = ALERT[13];
  assign _000_[13] = _057_;
  assign _059_ = ALERTo[14];
  assign _060_ = ALERT[14];
  assign _000_[14] = _062_;
  assign _064_ = ALERTo[15];
  assign _065_ = ALERT[15];
  assign _000_[15] = _067_;
  assign _069_ = GoodCRC_Response;
  assign _002_[0] = _072_;
  assign _002_[1] = _073_;
  assign _002_[2] = _075_;
  assign _002_[3] = _077_;
  assign _278_ = _078_;
  assign _280_ = _080_;
  assign _287_ = _082_;
  assign _085_ = TX_BUF_HEADER_BYTE_1[0];
  assign _086_ = RX_BUF_HEADER_BYTE_1[0];
  assign _088_ = TX_BUF_HEADER_BYTE_1[1];
  assign _090_ = RX_BUF_HEADER_BYTE_1[1];
  assign _091_ = TX_BUF_HEADER_BYTE_1[2];
  assign _093_ = RX_BUF_HEADER_BYTE_1[2];
  assign _095_ = TX_BUF_HEADER_BYTE_1[3];
  assign _097_ = RX_BUF_HEADER_BYTE_1[3];
  assign _099_ = TX_BUF_HEADER_BYTE_1[4];
  assign _101_ = RX_BUF_HEADER_BYTE_1[4];
  assign _103_ = TX_BUF_HEADER_BYTE_1[5];
  assign _105_ = RX_BUF_HEADER_BYTE_1[5];
  assign _107_ = TX_BUF_HEADER_BYTE_1[6];
  assign _109_ = RX_BUF_HEADER_BYTE_1[6];
  assign _111_ = TX_BUF_HEADER_BYTE_1[7];
  assign _113_ = RX_BUF_HEADER_BYTE_1[7];
  assign _115_ = TRANSMIT[0];
  assign _117_ = RX_BUF_FRAME_TYPE[0];
  assign _119_ = TRANSMIT[1];
  assign _121_ = RX_BUF_FRAME_TYPE[1];
  assign _123_ = RX_BUF_FRAME_TYPE[2];
endmodule