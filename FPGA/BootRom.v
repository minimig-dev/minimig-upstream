// Copyright 2006, 2007 Dennis van Weeren
//
// This file is part of Minimig
//
// Minimig is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// Minimig is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//
// This is the Minimig boot rom
// The bootrom contains code for early startup of the Minimig.
// The bootrom will download the kickstart rom image trough the floppy 
// interface to the kickstart ram area. 
//
// 11-04-2005	- removed rd signal because it is no longer necessary
// 19-04-2005	- expanded to 2Kbyte address space
// 21-12-2005	- added rd input
// 27-11-2006	- rom now implemented using blockram
// ----------
//
// JB:
// 2008-05-14	- Verilog 2001 style module definition
// 2008-05-14	- new bootloader
// 2008-09-27	- FPGA core version updated & code clean-up
// 2009-05-24	- clean-up & renaming
// 2009-06-06	- adapted bootloader for firmware with high resolution OSD display
// 2009-09-11	- updated bootloader code
// 2009-12-17	- updated bootloader code
// 2009-12-24	- updated version number
// 2010-06-03	- updated version number
// 2010-07-28	- updated version number
// 2010-08-18	- updated version number
 
module bootrom
(
	input 	clk,					// bus clock
	input 	aen,    				// rom enable
	input	rd,						// bus read
	input 	[10:1] address_in,		// address in
	output 	reg [15:0] data_out		// data out
);

reg	 	[10:1] romaddress;
reg		[15:0] romdata;

// use clocked address to infer blockram
always @(negedge clk)
	romaddress[10:1] <= address_in[10:1];

// the rom itself
// FPGA core version is stored in words 4-7 as 8 ASCII characters 
// bytes:
// 0-1: vendor id (YQ for JB :-)
// 2-3: year
// 4-5: month
// 6-7: day

// if all goes well this rom will be implemented using blockram
always @(romaddress)
begin
	case (romaddress)
		0000:	romdata[15:0] = 16'h0001;
		0001:	romdata[15:0] = 16'h0000;
		0002:	romdata[15:0] = 16'h0000;
		0003:	romdata[15:0] = 16'h0010;
		0004:	romdata[15:0] = 16'h5342; // fpga version - $5342 = SB
		0005:	romdata[15:0] = 16'h3133;
		0006:	romdata[15:0] = 16'h3130;
		0007:	romdata[15:0] = 16'h3230;
		0008:	romdata[15:0] = 16'h4DF9;
		0009:	romdata[15:0] = 16'h00DF;
		0010:	romdata[15:0] = 16'hF000;
		0011:	romdata[15:0] = 16'h6100;
		0012:	romdata[15:0] = 16'h0346;
		0013:	romdata[15:0] = 16'h3D7C;
		0014:	romdata[15:0] = 16'h9000;
		0015:	romdata[15:0] = 16'h0100;
		0016:	romdata[15:0] = 16'h3D7C;
		0017:	romdata[15:0] = 16'h0000;
		0018:	romdata[15:0] = 16'h0102;
		0019:	romdata[15:0] = 16'h3D7C;
		0020:	romdata[15:0] = 16'h0000;
		0021:	romdata[15:0] = 16'h0104;
		0022:	romdata[15:0] = 16'h3D7C;
		0023:	romdata[15:0] = 16'h0000;
		0024:	romdata[15:0] = 16'h0108;
		0025:	romdata[15:0] = 16'h3D7C;
		0026:	romdata[15:0] = 16'h0000;
		0027:	romdata[15:0] = 16'h010A;
		0028:	romdata[15:0] = 16'h3D7C;
		0029:	romdata[15:0] = 16'h003C;
		0030:	romdata[15:0] = 16'h0092;
		0031:	romdata[15:0] = 16'h3D7C;
		0032:	romdata[15:0] = 16'h00D4;
		0033:	romdata[15:0] = 16'h0094;
		0034:	romdata[15:0] = 16'h3D7C;
		0035:	romdata[15:0] = 16'h2C81;
		0036:	romdata[15:0] = 16'h008E;
		0037:	romdata[15:0] = 16'h3D7C;
		0038:	romdata[15:0] = 16'hF4C1;
		0039:	romdata[15:0] = 16'h0090;
		0040:	romdata[15:0] = 16'h3D7C;
		0041:	romdata[15:0] = 16'h0008;	// background color
		0042:	romdata[15:0] = 16'h0180;
		0043:	romdata[15:0] = 16'h3D7C;
		0044:	romdata[15:0] = 16'h0FFF;	// text color
		0045:	romdata[15:0] = 16'h0182;
		0046:	romdata[15:0] = 16'h41F9;
		0047:	romdata[15:0] = 16'h0000;
		0048:	romdata[15:0] = 16'h0378;
		0049:	romdata[15:0] = 16'h43F9;
		0050:	romdata[15:0] = 16'h0000;
		0051:	romdata[15:0] = 16'hC100;
		0052:	romdata[15:0] = 16'h7002;
		0053:	romdata[15:0] = 16'h22D8;
		0054:	romdata[15:0] = 16'h51C8;
		0055:	romdata[15:0] = 16'hFFFC;
		0056:	romdata[15:0] = 16'h2D7C;
		0057:	romdata[15:0] = 16'h0000;
		0058:	romdata[15:0] = 16'hC100;
		0059:	romdata[15:0] = 16'h0080;
		0060:	romdata[15:0] = 16'h3D40;
		0061:	romdata[15:0] = 16'h0088;
		0062:	romdata[15:0] = 16'h3D7C;
		0063:	romdata[15:0] = 16'h8390;
		0064:	romdata[15:0] = 16'h0096;
		0065:	romdata[15:0] = 16'h3D7C;
		0066:	romdata[15:0] = 16'h7FFF;
		0067:	romdata[15:0] = 16'h009E;
		0068:	romdata[15:0] = 16'h41F9;
		0069:	romdata[15:0] = 16'h0000;
		0070:	romdata[15:0] = 16'h0384;
		0071:	romdata[15:0] = 16'h6100;
		0072:	romdata[15:0] = 16'h02A8;
		0073:	romdata[15:0] = 16'h41F9;
		0074:	romdata[15:0] = 16'h0000;
		0075:	romdata[15:0] = 16'h0409;
		0076:	romdata[15:0] = 16'h6100;
		0077:	romdata[15:0] = 16'h029E;
		0078:	romdata[15:0] = 16'h41F9;
		0079:	romdata[15:0] = 16'h0000;
		0080:	romdata[15:0] = 16'h0420;
		0081:	romdata[15:0] = 16'h6100;
		0082:	romdata[15:0] = 16'h0294;
		0083:	romdata[15:0] = 16'h45F9;
		0084:	romdata[15:0] = 16'h0000;
		0085:	romdata[15:0] = 16'h0008;
		0086:	romdata[15:0] = 16'h7E07;
		0087:	romdata[15:0] = 16'h101A;
		0088:	romdata[15:0] = 16'h6100;
		0089:	romdata[15:0] = 16'h0232;
		0090:	romdata[15:0] = 16'h51CF;
		0091:	romdata[15:0] = 16'hFFF8;
		0092:	romdata[15:0] = 16'h41F9;
		0093:	romdata[15:0] = 16'h0000;
		0094:	romdata[15:0] = 16'h042D;
		0095:	romdata[15:0] = 16'h6100;
		0096:	romdata[15:0] = 16'h0278;
		0097:	romdata[15:0] = 16'h302E;
		0098:	romdata[15:0] = 16'h0004;
		0099:	romdata[15:0] = 16'hE048;
		0100:	romdata[15:0] = 16'h0200;
		0101:	romdata[15:0] = 16'h007F;
		0102:	romdata[15:0] = 16'h6100;
		0103:	romdata[15:0] = 16'h01F8;
		0104:	romdata[15:0] = 16'h41F9;
		0105:	romdata[15:0] = 16'h0000;
		0106:	romdata[15:0] = 16'h043B;
		0107:	romdata[15:0] = 16'h0801;
		0108:	romdata[15:0] = 16'h0004;
		0109:	romdata[15:0] = 16'h6700;
		0110:	romdata[15:0] = 16'h0008;
		0111:	romdata[15:0] = 16'h41F9;
		0112:	romdata[15:0] = 16'h0000;
		0113:	romdata[15:0] = 16'h0442;
		0114:	romdata[15:0] = 16'h6100;
		0115:	romdata[15:0] = 16'h0252;
		0116:	romdata[15:0] = 16'h41F9;
		0117:	romdata[15:0] = 16'h0000;
		0118:	romdata[15:0] = 16'h044A;
		0119:	romdata[15:0] = 16'h6100;
		0120:	romdata[15:0] = 16'h0248;
		0121:	romdata[15:0] = 16'h302E;
		0122:	romdata[15:0] = 16'h007C;
		0123:	romdata[15:0] = 16'h6100;
		0124:	romdata[15:0] = 16'h01CE;
		0125:	romdata[15:0] = 16'h700A;
		0126:	romdata[15:0] = 16'h6100;
		0127:	romdata[15:0] = 16'h01E6;
		0128:	romdata[15:0] = 16'h700A;
		0129:	romdata[15:0] = 16'h6100;
		0130:	romdata[15:0] = 16'h01E0;
		0131:	romdata[15:0] = 16'h13FC;
		0132:	romdata[15:0] = 16'h0003;
		0133:	romdata[15:0] = 16'h00BF;
		0134:	romdata[15:0] = 16'hE201;
		0135:	romdata[15:0] = 16'h13FC;
		0136:	romdata[15:0] = 16'h0000;
		0137:	romdata[15:0] = 16'h00BF;
		0138:	romdata[15:0] = 16'hE001;
		0139:	romdata[15:0] = 16'h13FC;
		0140:	romdata[15:0] = 16'h00FF;
		0141:	romdata[15:0] = 16'h00BF;
		0142:	romdata[15:0] = 16'hD300;
		0143:	romdata[15:0] = 16'h13FC;
		0144:	romdata[15:0] = 16'h00F7;
		0145:	romdata[15:0] = 16'h00BF;
		0146:	romdata[15:0] = 16'hD100;
		0147:	romdata[15:0] = 16'h13FC;
		0148:	romdata[15:0] = 16'h00F6;
		0149:	romdata[15:0] = 16'h00BF;
		0150:	romdata[15:0] = 16'hD100;
		0151:	romdata[15:0] = 16'h13FC;
		0152:	romdata[15:0] = 16'h00F7;
		0153:	romdata[15:0] = 16'h00BF;
		0154:	romdata[15:0] = 16'hD100;
		0155:	romdata[15:0] = 16'h0839;
		0156:	romdata[15:0] = 16'h0002;
		0157:	romdata[15:0] = 16'h00BF;
		0158:	romdata[15:0] = 16'hE001;
		0159:	romdata[15:0] = 16'h6700;
		0160:	romdata[15:0] = 16'hFFE6;
		0161:	romdata[15:0] = 16'h303C;
		0162:	romdata[15:0] = 16'h000C;
		0163:	romdata[15:0] = 16'h6100;
		0164:	romdata[15:0] = 16'h013E;
		0165:	romdata[15:0] = 16'h207C;
		0166:	romdata[15:0] = 16'h0000;
		0167:	romdata[15:0] = 16'h4000;
		0168:	romdata[15:0] = 16'h0C58;
		0169:	romdata[15:0] = 16'hAA69;
		0170:	romdata[15:0] = 16'h6600;
		0171:	romdata[15:0] = 16'h0118;
		0172:	romdata[15:0] = 16'h3018;
		0173:	romdata[15:0] = 16'h0C40;
		0174:	romdata[15:0] = 16'h0001;
		0175:	romdata[15:0] = 16'h6600;
		0176:	romdata[15:0] = 16'h001C;
		0177:	romdata[15:0] = 16'h2018;
		0178:	romdata[15:0] = 16'h6100;
		0179:	romdata[15:0] = 16'h0120;
		0180:	romdata[15:0] = 16'h41F9;
		0181:	romdata[15:0] = 16'h0000;
		0182:	romdata[15:0] = 16'h4000;
		0183:	romdata[15:0] = 16'h6100;
		0184:	romdata[15:0] = 16'h01C8;
		0185:	romdata[15:0] = 16'h700A;
		0186:	romdata[15:0] = 16'h6100;
		0187:	romdata[15:0] = 16'h016E;
		0188:	romdata[15:0] = 16'h6000;
		0189:	romdata[15:0] = 16'h0108;
		0190:	romdata[15:0] = 16'h0C40;
		0191:	romdata[15:0] = 16'h0002;
		0192:	romdata[15:0] = 16'h6600;
		0193:	romdata[15:0] = 16'h009E;
		0194:	romdata[15:0] = 16'h2858;
		0195:	romdata[15:0] = 16'h2A4C;
		0196:	romdata[15:0] = 16'h2818;
		0197:	romdata[15:0] = 16'h2A04;
		0198:	romdata[15:0] = 16'h41F9;
		0199:	romdata[15:0] = 16'h0000;
		0200:	romdata[15:0] = 16'h0458;
		0201:	romdata[15:0] = 16'h6100;
		0202:	romdata[15:0] = 16'h01A4;
		0203:	romdata[15:0] = 16'h200C;
		0204:	romdata[15:0] = 16'h6100;
		0205:	romdata[15:0] = 16'h0118;
		0206:	romdata[15:0] = 16'h41F9;
		0207:	romdata[15:0] = 16'h0000;
		0208:	romdata[15:0] = 16'h0467;
		0209:	romdata[15:0] = 16'h6100;
		0210:	romdata[15:0] = 16'h0194;
		0211:	romdata[15:0] = 16'h2004;
		0212:	romdata[15:0] = 16'h6100;
		0213:	romdata[15:0] = 16'h0108;
		0214:	romdata[15:0] = 16'h700A;
		0215:	romdata[15:0] = 16'h6100;
		0216:	romdata[15:0] = 16'h0134;
		0217:	romdata[15:0] = 16'h41F9;
		0218:	romdata[15:0] = 16'h0000;
		0219:	romdata[15:0] = 16'h0471;
		0220:	romdata[15:0] = 16'h6100;
		0221:	romdata[15:0] = 16'h017E;
		0222:	romdata[15:0] = 16'h0442;
		0223:	romdata[15:0] = 16'h0021;
		0224:	romdata[15:0] = 16'h96FC;
		0225:	romdata[15:0] = 16'h0021;
		0226:	romdata[15:0] = 16'h2C05;
		0227:	romdata[15:0] = 16'hEA8E;
		0228:	romdata[15:0] = 16'hBC84;
		0229:	romdata[15:0] = 16'h6D00;
		0230:	romdata[15:0] = 16'h0004;
		0231:	romdata[15:0] = 16'h2C04;
		0232:	romdata[15:0] = 16'h3006;
		0233:	romdata[15:0] = 16'h6100;
		0234:	romdata[15:0] = 16'h00B2;
		0235:	romdata[15:0] = 16'h3006;
		0236:	romdata[15:0] = 16'hE448;
		0237:	romdata[15:0] = 16'h5340;
		0238:	romdata[15:0] = 16'h28D8;
		0239:	romdata[15:0] = 16'h51C8;
		0240:	romdata[15:0] = 16'hFFFC;
		0241:	romdata[15:0] = 16'h707F;
		0242:	romdata[15:0] = 16'h6100;
		0243:	romdata[15:0] = 16'h00FE;
		0244:	romdata[15:0] = 16'h0879;
		0245:	romdata[15:0] = 16'h0001;
		0246:	romdata[15:0] = 16'h00BF;
		0247:	romdata[15:0] = 16'hE001;
		0248:	romdata[15:0] = 16'h9886;
		0249:	romdata[15:0] = 16'h6E00;
		0250:	romdata[15:0] = 16'hFFD0;
		0251:	romdata[15:0] = 16'hBBFC;
		0252:	romdata[15:0] = 16'h00F8;
		0253:	romdata[15:0] = 16'h0000;
		0254:	romdata[15:0] = 16'h6600;
		0255:	romdata[15:0] = 16'h0018;
		0256:	romdata[15:0] = 16'h0C85;
		0257:	romdata[15:0] = 16'h0004;
		0258:	romdata[15:0] = 16'h0000;
		0259:	romdata[15:0] = 16'h6600;
		0260:	romdata[15:0] = 16'h000E;
		0261:	romdata[15:0] = 16'h284D;
		0262:	romdata[15:0] = 16'hD9C5;
		0263:	romdata[15:0] = 16'h7AFF;
		0264:	romdata[15:0] = 16'h28DD;
		0265:	romdata[15:0] = 16'h51CD;
		0266:	romdata[15:0] = 16'hFFFC;
		0267:	romdata[15:0] = 16'h700A;
		0268:	romdata[15:0] = 16'h6100;
		0269:	romdata[15:0] = 16'h00CA;
		0270:	romdata[15:0] = 16'h6000;
		0271:	romdata[15:0] = 16'h0064;
		0272:	romdata[15:0] = 16'h0C40;
		0273:	romdata[15:0] = 16'h0003;
		0274:	romdata[15:0] = 16'h6600;
		0275:	romdata[15:0] = 16'h0012;
		0276:	romdata[15:0] = 16'h08F9;
		0277:	romdata[15:0] = 16'h0001;
		0278:	romdata[15:0] = 16'h00BF;
		0279:	romdata[15:0] = 16'hE001;
		0280:	romdata[15:0] = 16'h4A39;
		0281:	romdata[15:0] = 16'h00BF;
		0282:	romdata[15:0] = 16'hC000;
		0283:	romdata[15:0] = 16'h60FE;
		0284:	romdata[15:0] = 16'h0C40;
		0285:	romdata[15:0] = 16'h0004;
		0286:	romdata[15:0] = 16'h6600;
		0287:	romdata[15:0] = 16'h0014;
		0288:	romdata[15:0] = 16'h2858;
		0289:	romdata[15:0] = 16'h2818;
		0290:	romdata[15:0] = 16'h7000;
		0291:	romdata[15:0] = 16'h28C0;
		0292:	romdata[15:0] = 16'h5984;
		0293:	romdata[15:0] = 16'h6E00;
		0294:	romdata[15:0] = 16'hFFFA;
		0295:	romdata[15:0] = 16'h6000;
		0296:	romdata[15:0] = 16'h0032;
		0297:	romdata[15:0] = 16'h3E00;
		0298:	romdata[15:0] = 16'h3D7C;
		0299:	romdata[15:0] = 16'h0F00;
		0300:	romdata[15:0] = 16'h0180;
		0301:	romdata[15:0] = 16'h41F9;
		0302:	romdata[15:0] = 16'h0000;
		0303:	romdata[15:0] = 16'h04B0;
		0304:	romdata[15:0] = 16'h6100;
		0305:	romdata[15:0] = 16'h00D6;
		0306:	romdata[15:0] = 16'h3007;
		0307:	romdata[15:0] = 16'h6100;
		0308:	romdata[15:0] = 16'h0054;
		0309:	romdata[15:0] = 16'h6000;
		0310:	romdata[15:0] = 16'hFFFE;
		0311:	romdata[15:0] = 16'h3D7C;
		0312:	romdata[15:0] = 16'h0F00;
		0313:	romdata[15:0] = 16'h0180;
		0314:	romdata[15:0] = 16'h41F9;
		0315:	romdata[15:0] = 16'h0000;
		0316:	romdata[15:0] = 16'h0494;
		0317:	romdata[15:0] = 16'h6100;
		0318:	romdata[15:0] = 16'h00BC;
		0319:	romdata[15:0] = 16'h6000;
		0320:	romdata[15:0] = 16'hFFEA;
		0321:	romdata[15:0] = 16'h6000;
		0322:	romdata[15:0] = 16'hFEBE;
		0323:	romdata[15:0] = 16'h3D7C;
		0324:	romdata[15:0] = 16'h0002;
		0325:	romdata[15:0] = 16'h009C;
		0326:	romdata[15:0] = 16'h207C;
		0327:	romdata[15:0] = 16'h0000;
		0328:	romdata[15:0] = 16'h4000;
		0329:	romdata[15:0] = 16'h2D48;
		0330:	romdata[15:0] = 16'h0020;
		0331:	romdata[15:0] = 16'hE248;
		0332:	romdata[15:0] = 16'h0040;
		0333:	romdata[15:0] = 16'h8000;
		0334:	romdata[15:0] = 16'h3D40;
		0335:	romdata[15:0] = 16'h0024;
		0336:	romdata[15:0] = 16'h3D40;
		0337:	romdata[15:0] = 16'h0024;
		0338:	romdata[15:0] = 16'h302E;
		0339:	romdata[15:0] = 16'h001E;
		0340:	romdata[15:0] = 16'h0800;
		0341:	romdata[15:0] = 16'h0001;
		0342:	romdata[15:0] = 16'h6700;
		0343:	romdata[15:0] = 16'hFFF6;
		0344:	romdata[15:0] = 16'h4E75;
		0345:	romdata[15:0] = 16'h4840;
		0346:	romdata[15:0] = 16'h6100;
		0347:	romdata[15:0] = 16'h0006;
		0348:	romdata[15:0] = 16'h4841;
		0349:	romdata[15:0] = 16'h2001;
		0350:	romdata[15:0] = 16'hE058;
		0351:	romdata[15:0] = 16'h6100;
		0352:	romdata[15:0] = 16'h0006;
		0353:	romdata[15:0] = 16'h2001;
		0354:	romdata[15:0] = 16'hE058;
		0355:	romdata[15:0] = 16'h2200;
		0356:	romdata[15:0] = 16'hE808;
		0357:	romdata[15:0] = 16'h6100;
		0358:	romdata[15:0] = 16'h0008;
		0359:	romdata[15:0] = 16'h2001;
		0360:	romdata[15:0] = 16'h0200;
		0361:	romdata[15:0] = 16'h000F;
		0362:	romdata[15:0] = 16'h0600;
		0363:	romdata[15:0] = 16'h0030;
		0364:	romdata[15:0] = 16'h0C00;
		0365:	romdata[15:0] = 16'h0039;
		0366:	romdata[15:0] = 16'h6F00;
		0367:	romdata[15:0] = 16'h0006;
		0368:	romdata[15:0] = 16'h0600;
		0369:	romdata[15:0] = 16'h0007;
		0370:	romdata[15:0] = 16'h224B;
		0371:	romdata[15:0] = 16'h47EB;
		0372:	romdata[15:0] = 16'h0001;
		0373:	romdata[15:0] = 16'h0C00;
		0374:	romdata[15:0] = 16'h000A;
		0375:	romdata[15:0] = 16'h660C;
		0376:	romdata[15:0] = 16'h96C2;
		0377:	romdata[15:0] = 16'h343C;
		0378:	romdata[15:0] = 16'h0000;
		0379:	romdata[15:0] = 16'h47EB;
		0380:	romdata[15:0] = 16'h027F;
		0381:	romdata[15:0] = 16'h602A;
		0382:	romdata[15:0] = 16'h4880;
		0383:	romdata[15:0] = 16'h0440;
		0384:	romdata[15:0] = 16'h0020;
		0385:	romdata[15:0] = 16'hE740;
		0386:	romdata[15:0] = 16'h41F9;
		0387:	romdata[15:0] = 16'h0000;
		0388:	romdata[15:0] = 16'h04C4;
		0389:	romdata[15:0] = 16'hD0C0;
		0390:	romdata[15:0] = 16'h7007;
		0391:	romdata[15:0] = 16'h1298;
		0392:	romdata[15:0] = 16'h43E9;
		0393:	romdata[15:0] = 16'h0050;
		0394:	romdata[15:0] = 16'h51C8;
		0395:	romdata[15:0] = 16'hFFF8;
		0396:	romdata[15:0] = 16'h5242;
		0397:	romdata[15:0] = 16'h0C42;
		0398:	romdata[15:0] = 16'h0050;
		0399:	romdata[15:0] = 16'h6616;
		0400:	romdata[15:0] = 16'h7400;
		0401:	romdata[15:0] = 16'hD6FC;
		0402:	romdata[15:0] = 16'h0230;
		0403:	romdata[15:0] = 16'h5243;
		0404:	romdata[15:0] = 16'h0C43;
		0405:	romdata[15:0] = 16'h0019;
		0406:	romdata[15:0] = 16'h6608;
		0407:	romdata[15:0] = 16'h5343;
		0408:	romdata[15:0] = 16'h96FC;
		0409:	romdata[15:0] = 16'h0280;
		0410:	romdata[15:0] = 16'h6112;
		0411:	romdata[15:0] = 16'h4E75;
		0412:	romdata[15:0] = 16'h2448;
		0413:	romdata[15:0] = 16'h224B;
		0414:	romdata[15:0] = 16'h7000;
		0415:	romdata[15:0] = 16'h101A;
		0416:	romdata[15:0] = 16'h6704;
		0417:	romdata[15:0] = 16'h61A0;
		0418:	romdata[15:0] = 16'h60F4;
		0419:	romdata[15:0] = 16'h4E75;
		0420:	romdata[15:0] = 16'h41F9;
		0421:	romdata[15:0] = 16'h0000;
		0422:	romdata[15:0] = 16'h8000;
		0423:	romdata[15:0] = 16'h43E8;
		0424:	romdata[15:0] = 16'h0280;
		0425:	romdata[15:0] = 16'h303C;
		0426:	romdata[15:0] = 16'h0F9F;
		0427:	romdata[15:0] = 16'h20D9;
		0428:	romdata[15:0] = 16'h51C8;
		0429:	romdata[15:0] = 16'hFFFC;
		0430:	romdata[15:0] = 16'h4E75;
		0431:	romdata[15:0] = 16'h7400;
		0432:	romdata[15:0] = 16'h7600;
		0433:	romdata[15:0] = 16'h47F9;
		0434:	romdata[15:0] = 16'h0000;
		0435:	romdata[15:0] = 16'h8000;
		0436:	romdata[15:0] = 16'h204B;
		0437:	romdata[15:0] = 16'h7000;
		0438:	romdata[15:0] = 16'h323C;
		0439:	romdata[15:0] = 16'h103F;
		0440:	romdata[15:0] = 16'h20C0;
		0441:	romdata[15:0] = 16'h51C9;
		0442:	romdata[15:0] = 16'hFFFC;
		0443:	romdata[15:0] = 16'h4E75;
		0444:	romdata[15:0] = 16'h00E0;
		0445:	romdata[15:0] = 16'h0000;
		0446:	romdata[15:0] = 16'h00E2;
		0447:	romdata[15:0] = 16'h8000;
		0448:	romdata[15:0] = 16'hFFFF;
		0449:	romdata[15:0] = 16'hFFFE;
		0450:	romdata[15:0] = 16'h4D69;
		0451:	romdata[15:0] = 16'h6E69;
		0452:	romdata[15:0] = 16'h6D69;
		0453:	romdata[15:0] = 16'h6720;
		0454:	romdata[15:0] = 16'h6279;
		0455:	romdata[15:0] = 16'h2044;
		0456:	romdata[15:0] = 16'h656E;
		0457:	romdata[15:0] = 16'h6E69;
		0458:	romdata[15:0] = 16'h7320;
		0459:	romdata[15:0] = 16'h7661;
		0460:	romdata[15:0] = 16'h6E20;
		0461:	romdata[15:0] = 16'h5765;
		0462:	romdata[15:0] = 16'h6572;
		0463:	romdata[15:0] = 16'h656E;
		0464:	romdata[15:0] = 16'h0A42;
		0465:	romdata[15:0] = 16'h7567;
		0466:	romdata[15:0] = 16'h2066;
		0467:	romdata[15:0] = 16'h6978;
		0468:	romdata[15:0] = 16'h6573;
		0469:	romdata[15:0] = 16'h2C20;
		0470:	romdata[15:0] = 16'h6D6F;
		0471:	romdata[15:0] = 16'h6473;
		0472:	romdata[15:0] = 16'h2061;
		0473:	romdata[15:0] = 16'h6E64;
		0474:	romdata[15:0] = 16'h2065;
		0475:	romdata[15:0] = 16'h7874;
		0476:	romdata[15:0] = 16'h656E;
		0477:	romdata[15:0] = 16'h7369;
		0478:	romdata[15:0] = 16'h6F6E;
		0479:	romdata[15:0] = 16'h7320;
		0480:	romdata[15:0] = 16'h6279;
		0481:	romdata[15:0] = 16'h204A;
		0482:	romdata[15:0] = 16'h616B;
		0483:	romdata[15:0] = 16'h7562;
		0484:	romdata[15:0] = 16'h2042;
		0485:	romdata[15:0] = 16'h6564;
		0486:	romdata[15:0] = 16'h6E61;
		0487:	romdata[15:0] = 16'h7273;
		0488:	romdata[15:0] = 16'h6B69;
		0489:	romdata[15:0] = 16'h0A46;
		0490:	romdata[15:0] = 16'h6F72;
		0491:	romdata[15:0] = 16'h2075;
		0492:	romdata[15:0] = 16'h7064;
		0493:	romdata[15:0] = 16'h6174;
		0494:	romdata[15:0] = 16'h6573;
		0495:	romdata[15:0] = 16'h2061;
		0496:	romdata[15:0] = 16'h6E64;
		0497:	romdata[15:0] = 16'h2073;
		0498:	romdata[15:0] = 16'h7570;
		0499:	romdata[15:0] = 16'h706F;
		0500:	romdata[15:0] = 16'h7274;
		0501:	romdata[15:0] = 16'h2070;
		0502:	romdata[15:0] = 16'h6C65;
		0503:	romdata[15:0] = 16'h6173;
		0504:	romdata[15:0] = 16'h6520;
		0505:	romdata[15:0] = 16'h7669;
		0506:	romdata[15:0] = 16'h7369;
		0507:	romdata[15:0] = 16'h7420;
		0508:	romdata[15:0] = 16'h7777;
		0509:	romdata[15:0] = 16'h772E;
		0510:	romdata[15:0] = 16'h6D69;
		0511:	romdata[15:0] = 16'h6E69;
		0512:	romdata[15:0] = 16'h6D69;
		0513:	romdata[15:0] = 16'h672E;
		0514:	romdata[15:0] = 16'h6E65;
		0515:	romdata[15:0] = 16'h740A;
		0516:	romdata[15:0] = 16'h000A;
		0517:	romdata[15:0] = 16'h426F;
		0518:	romdata[15:0] = 16'h6F74;
		0519:	romdata[15:0] = 16'h6C6F;
		0520:	romdata[15:0] = 16'h6164;
		0521:	romdata[15:0] = 16'h6572;
		0522:	romdata[15:0] = 16'h2042;
		0523:	romdata[15:0] = 16'h5951;
		0524:	romdata[15:0] = 16'h3130;
		0525:	romdata[15:0] = 16'h3034;
		0526:	romdata[15:0] = 16'h3133;
		0527:	romdata[15:0] = 16'h0A00;
		0528:	romdata[15:0] = 16'h0A46;
		0529:	romdata[15:0] = 16'h5047;
		0530:	romdata[15:0] = 16'h4120;
		0531:	romdata[15:0] = 16'h636F;
		0532:	romdata[15:0] = 16'h7265;
		0533:	romdata[15:0] = 16'h2046;
		0534:	romdata[15:0] = 16'h000A;
		0535:	romdata[15:0] = 16'h0A41;
		0536:	romdata[15:0] = 16'h676E;
		0537:	romdata[15:0] = 16'h7573;
		0538:	romdata[15:0] = 16'h2049;
		0539:	romdata[15:0] = 16'h443A;
		0540:	romdata[15:0] = 16'h2024;
		0541:	romdata[15:0] = 16'h0020;
		0542:	romdata[15:0] = 16'h2850;
		0543:	romdata[15:0] = 16'h414C;
		0544:	romdata[15:0] = 16'h2900;
		0545:	romdata[15:0] = 16'h2028;
		0546:	romdata[15:0] = 16'h4E54;
		0547:	romdata[15:0] = 16'h5343;
		0548:	romdata[15:0] = 16'h2900;
		0549:	romdata[15:0] = 16'h2044;
		0550:	romdata[15:0] = 16'h656E;
		0551:	romdata[15:0] = 16'h6973;
		0552:	romdata[15:0] = 16'h6520;
		0553:	romdata[15:0] = 16'h4944;
		0554:	romdata[15:0] = 16'h3A20;
		0555:	romdata[15:0] = 16'h2400;
		0556:	romdata[15:0] = 16'h4D65;
		0557:	romdata[15:0] = 16'h6D6F;
		0558:	romdata[15:0] = 16'h7279;
		0559:	romdata[15:0] = 16'h2062;
		0560:	romdata[15:0] = 16'h6173;
		0561:	romdata[15:0] = 16'h653A;
		0562:	romdata[15:0] = 16'h2024;
		0563:	romdata[15:0] = 16'h002C;
		0564:	romdata[15:0] = 16'h2073;
		0565:	romdata[15:0] = 16'h697A;
		0566:	romdata[15:0] = 16'h653A;
		0567:	romdata[15:0] = 16'h2024;
		0568:	romdata[15:0] = 16'h005B;
		0569:	romdata[15:0] = 16'h5F5F;
		0570:	romdata[15:0] = 16'h5F5F;
		0571:	romdata[15:0] = 16'h5F5F;
		0572:	romdata[15:0] = 16'h5F5F;
		0573:	romdata[15:0] = 16'h5F5F;
		0574:	romdata[15:0] = 16'h5F5F;
		0575:	romdata[15:0] = 16'h5F5F;
		0576:	romdata[15:0] = 16'h5F5F;
		0577:	romdata[15:0] = 16'h5F5F;
		0578:	romdata[15:0] = 16'h5F5F;
		0579:	romdata[15:0] = 16'h5F5F;
		0580:	romdata[15:0] = 16'h5F5F;
		0581:	romdata[15:0] = 16'h5F5F;
		0582:	romdata[15:0] = 16'h5F5F;
		0583:	romdata[15:0] = 16'h5F5F;
		0584:	romdata[15:0] = 16'h5F5F;
		0585:	romdata[15:0] = 16'h5D00;
		0586:	romdata[15:0] = 16'h0A49;
		0587:	romdata[15:0] = 16'h6E63;
		0588:	romdata[15:0] = 16'h6F6D;
		0589:	romdata[15:0] = 16'h7061;
		0590:	romdata[15:0] = 16'h7469;
		0591:	romdata[15:0] = 16'h626C;
		0592:	romdata[15:0] = 16'h6520;
		0593:	romdata[15:0] = 16'h4D43;
		0594:	romdata[15:0] = 16'h5520;
		0595:	romdata[15:0] = 16'h6669;
		0596:	romdata[15:0] = 16'h726D;
		0597:	romdata[15:0] = 16'h7761;
		0598:	romdata[15:0] = 16'h7265;
		0599:	romdata[15:0] = 16'h2100;
		0600:	romdata[15:0] = 16'h0A55;
		0601:	romdata[15:0] = 16'h6E6B;
		0602:	romdata[15:0] = 16'h6E6F;
		0603:	romdata[15:0] = 16'h776E;
		0604:	romdata[15:0] = 16'h2063;
		0605:	romdata[15:0] = 16'h6F6D;
		0606:	romdata[15:0] = 16'h6D61;
		0607:	romdata[15:0] = 16'h6E64;
		0608:	romdata[15:0] = 16'h3A20;
		0609:	romdata[15:0] = 16'h2400;
		0610:	romdata[15:0] = 16'h0000;
		0611:	romdata[15:0] = 16'h0000;
		0612:	romdata[15:0] = 16'h0000;
		0613:	romdata[15:0] = 16'h0000;
		0614:	romdata[15:0] = 16'h1818;
		0615:	romdata[15:0] = 16'h1818;
		0616:	romdata[15:0] = 16'h1800;
		0617:	romdata[15:0] = 16'h1800;
		0618:	romdata[15:0] = 16'h6C6C;
		0619:	romdata[15:0] = 16'h0000;
		0620:	romdata[15:0] = 16'h0000;
		0621:	romdata[15:0] = 16'h0000;
		0622:	romdata[15:0] = 16'h6C6C;
		0623:	romdata[15:0] = 16'hFE6C;
		0624:	romdata[15:0] = 16'hFE6C;
		0625:	romdata[15:0] = 16'h6C00;
		0626:	romdata[15:0] = 16'h183E;
		0627:	romdata[15:0] = 16'h603C;
		0628:	romdata[15:0] = 16'h067C;
		0629:	romdata[15:0] = 16'h1800;
		0630:	romdata[15:0] = 16'h0066;
		0631:	romdata[15:0] = 16'hACD8;
		0632:	romdata[15:0] = 16'h366A;
		0633:	romdata[15:0] = 16'hCC00;
		0634:	romdata[15:0] = 16'h386C;
		0635:	romdata[15:0] = 16'h6876;
		0636:	romdata[15:0] = 16'hDCCE;
		0637:	romdata[15:0] = 16'h7B00;
		0638:	romdata[15:0] = 16'h1818;
		0639:	romdata[15:0] = 16'h3000;
		0640:	romdata[15:0] = 16'h0000;
		0641:	romdata[15:0] = 16'h0000;
		0642:	romdata[15:0] = 16'h0C18;
		0643:	romdata[15:0] = 16'h3030;
		0644:	romdata[15:0] = 16'h3018;
		0645:	romdata[15:0] = 16'h0C00;
		0646:	romdata[15:0] = 16'h3018;
		0647:	romdata[15:0] = 16'h0C0C;
		0648:	romdata[15:0] = 16'h0C18;
		0649:	romdata[15:0] = 16'h3000;
		0650:	romdata[15:0] = 16'h0066;
		0651:	romdata[15:0] = 16'h3CFF;
		0652:	romdata[15:0] = 16'h3C66;
		0653:	romdata[15:0] = 16'h0000;
		0654:	romdata[15:0] = 16'h0018;
		0655:	romdata[15:0] = 16'h187E;
		0656:	romdata[15:0] = 16'h1818;
		0657:	romdata[15:0] = 16'h0000;
		0658:	romdata[15:0] = 16'h0000;
		0659:	romdata[15:0] = 16'h0000;
		0660:	romdata[15:0] = 16'h0018;
		0661:	romdata[15:0] = 16'h1830;
		0662:	romdata[15:0] = 16'h0000;
		0663:	romdata[15:0] = 16'h007E;
		0664:	romdata[15:0] = 16'h0000;
		0665:	romdata[15:0] = 16'h0000;
		0666:	romdata[15:0] = 16'h0000;
		0667:	romdata[15:0] = 16'h0000;
		0668:	romdata[15:0] = 16'h0018;
		0669:	romdata[15:0] = 16'h1800;
		0670:	romdata[15:0] = 16'h0306;
		0671:	romdata[15:0] = 16'h0C18;
		0672:	romdata[15:0] = 16'h3060;
		0673:	romdata[15:0] = 16'hC000;
		0674:	romdata[15:0] = 16'h3C66;
		0675:	romdata[15:0] = 16'h6E7E;
		0676:	romdata[15:0] = 16'h7666;
		0677:	romdata[15:0] = 16'h3C00;
		0678:	romdata[15:0] = 16'h1838;
		0679:	romdata[15:0] = 16'h7818;
		0680:	romdata[15:0] = 16'h1818;
		0681:	romdata[15:0] = 16'h1800;
		0682:	romdata[15:0] = 16'h3C66;
		0683:	romdata[15:0] = 16'h060C;
		0684:	romdata[15:0] = 16'h1830;
		0685:	romdata[15:0] = 16'h7E00;
		0686:	romdata[15:0] = 16'h3C66;
		0687:	romdata[15:0] = 16'h061C;
		0688:	romdata[15:0] = 16'h0666;
		0689:	romdata[15:0] = 16'h3C00;
		0690:	romdata[15:0] = 16'h1C3C;
		0691:	romdata[15:0] = 16'h6CCC;
		0692:	romdata[15:0] = 16'hFE0C;
		0693:	romdata[15:0] = 16'h0C00;
		0694:	romdata[15:0] = 16'h7E60;
		0695:	romdata[15:0] = 16'h7C06;
		0696:	romdata[15:0] = 16'h0666;
		0697:	romdata[15:0] = 16'h3C00;
		0698:	romdata[15:0] = 16'h1C30;
		0699:	romdata[15:0] = 16'h607C;
		0700:	romdata[15:0] = 16'h6666;
		0701:	romdata[15:0] = 16'h3C00;
		0702:	romdata[15:0] = 16'h7E06;
		0703:	romdata[15:0] = 16'h060C;
		0704:	romdata[15:0] = 16'h1818;
		0705:	romdata[15:0] = 16'h1800;
		0706:	romdata[15:0] = 16'h3C66;
		0707:	romdata[15:0] = 16'h663C;
		0708:	romdata[15:0] = 16'h6666;
		0709:	romdata[15:0] = 16'h3C00;
		0710:	romdata[15:0] = 16'h3C66;
		0711:	romdata[15:0] = 16'h663E;
		0712:	romdata[15:0] = 16'h060C;
		0713:	romdata[15:0] = 16'h3800;
		0714:	romdata[15:0] = 16'h0018;
		0715:	romdata[15:0] = 16'h1800;
		0716:	romdata[15:0] = 16'h0018;
		0717:	romdata[15:0] = 16'h1800;
		0718:	romdata[15:0] = 16'h0018;
		0719:	romdata[15:0] = 16'h1800;
		0720:	romdata[15:0] = 16'h0018;
		0721:	romdata[15:0] = 16'h1830;
		0722:	romdata[15:0] = 16'h0006;
		0723:	romdata[15:0] = 16'h1860;
		0724:	romdata[15:0] = 16'h1806;
		0725:	romdata[15:0] = 16'h0000;
		0726:	romdata[15:0] = 16'h0000;
		0727:	romdata[15:0] = 16'h7E00;
		0728:	romdata[15:0] = 16'h7E00;
		0729:	romdata[15:0] = 16'h0000;
		0730:	romdata[15:0] = 16'h0060;
		0731:	romdata[15:0] = 16'h1806;
		0732:	romdata[15:0] = 16'h1860;
		0733:	romdata[15:0] = 16'h0000;
		0734:	romdata[15:0] = 16'h3C66;
		0735:	romdata[15:0] = 16'h060C;
		0736:	romdata[15:0] = 16'h1800;
		0737:	romdata[15:0] = 16'h1800;
		0738:	romdata[15:0] = 16'h7CC6;
		0739:	romdata[15:0] = 16'hDED6;
		0740:	romdata[15:0] = 16'hDEC0;
		0741:	romdata[15:0] = 16'h7800;
		0742:	romdata[15:0] = 16'h3C66;
		0743:	romdata[15:0] = 16'h667E;
		0744:	romdata[15:0] = 16'h6666;
		0745:	romdata[15:0] = 16'h6600;
		0746:	romdata[15:0] = 16'h7C66;
		0747:	romdata[15:0] = 16'h667C;
		0748:	romdata[15:0] = 16'h6666;
		0749:	romdata[15:0] = 16'h7C00;
		0750:	romdata[15:0] = 16'h1E30;
		0751:	romdata[15:0] = 16'h6060;
		0752:	romdata[15:0] = 16'h6030;
		0753:	romdata[15:0] = 16'h1E00;
		0754:	romdata[15:0] = 16'h786C;
		0755:	romdata[15:0] = 16'h6666;
		0756:	romdata[15:0] = 16'h666C;
		0757:	romdata[15:0] = 16'h7800;
		0758:	romdata[15:0] = 16'h7E60;
		0759:	romdata[15:0] = 16'h6078;
		0760:	romdata[15:0] = 16'h6060;
		0761:	romdata[15:0] = 16'h7E00;
		0762:	romdata[15:0] = 16'h7E60;
		0763:	romdata[15:0] = 16'h6078;
		0764:	romdata[15:0] = 16'h6060;
		0765:	romdata[15:0] = 16'h6000;
		0766:	romdata[15:0] = 16'h3C66;
		0767:	romdata[15:0] = 16'h606E;
		0768:	romdata[15:0] = 16'h6666;
		0769:	romdata[15:0] = 16'h3E00;
		0770:	romdata[15:0] = 16'h6666;
		0771:	romdata[15:0] = 16'h667E;
		0772:	romdata[15:0] = 16'h6666;
		0773:	romdata[15:0] = 16'h6600;
		0774:	romdata[15:0] = 16'h3C18;
		0775:	romdata[15:0] = 16'h1818;
		0776:	romdata[15:0] = 16'h1818;
		0777:	romdata[15:0] = 16'h3C00;
		0778:	romdata[15:0] = 16'h0606;
		0779:	romdata[15:0] = 16'h0606;
		0780:	romdata[15:0] = 16'h0666;
		0781:	romdata[15:0] = 16'h3C00;
		0782:	romdata[15:0] = 16'hC6CC;
		0783:	romdata[15:0] = 16'hD8F0;
		0784:	romdata[15:0] = 16'hD8CC;
		0785:	romdata[15:0] = 16'hC600;
		0786:	romdata[15:0] = 16'h6060;
		0787:	romdata[15:0] = 16'h6060;
		0788:	romdata[15:0] = 16'h6060;
		0789:	romdata[15:0] = 16'h7E00;
		0790:	romdata[15:0] = 16'hC6EE;
		0791:	romdata[15:0] = 16'hFED6;
		0792:	romdata[15:0] = 16'hC6C6;
		0793:	romdata[15:0] = 16'hC600;
		0794:	romdata[15:0] = 16'hC6E6;
		0795:	romdata[15:0] = 16'hF6DE;
		0796:	romdata[15:0] = 16'hCEC6;
		0797:	romdata[15:0] = 16'hC600;
		0798:	romdata[15:0] = 16'h3C66;
		0799:	romdata[15:0] = 16'h6666;
		0800:	romdata[15:0] = 16'h6666;
		0801:	romdata[15:0] = 16'h3C00;
		0802:	romdata[15:0] = 16'h7C66;
		0803:	romdata[15:0] = 16'h667C;
		0804:	romdata[15:0] = 16'h6060;
		0805:	romdata[15:0] = 16'h6000;
		0806:	romdata[15:0] = 16'h78CC;
		0807:	romdata[15:0] = 16'hCCCC;
		0808:	romdata[15:0] = 16'hCCDC;
		0809:	romdata[15:0] = 16'h7E00;
		0810:	romdata[15:0] = 16'h7C66;
		0811:	romdata[15:0] = 16'h667C;
		0812:	romdata[15:0] = 16'h6C66;
		0813:	romdata[15:0] = 16'h6600;
		0814:	romdata[15:0] = 16'h3C66;
		0815:	romdata[15:0] = 16'h703C;
		0816:	romdata[15:0] = 16'h0E66;
		0817:	romdata[15:0] = 16'h3C00;
		0818:	romdata[15:0] = 16'h7E18;
		0819:	romdata[15:0] = 16'h1818;
		0820:	romdata[15:0] = 16'h1818;
		0821:	romdata[15:0] = 16'h1800;
		0822:	romdata[15:0] = 16'h6666;
		0823:	romdata[15:0] = 16'h6666;
		0824:	romdata[15:0] = 16'h6666;
		0825:	romdata[15:0] = 16'h3C00;
		0826:	romdata[15:0] = 16'h6666;
		0827:	romdata[15:0] = 16'h6666;
		0828:	romdata[15:0] = 16'h3C3C;
		0829:	romdata[15:0] = 16'h1800;
		0830:	romdata[15:0] = 16'hC6C6;
		0831:	romdata[15:0] = 16'hC6D6;
		0832:	romdata[15:0] = 16'hFEEE;
		0833:	romdata[15:0] = 16'hC600;
		0834:	romdata[15:0] = 16'hC366;
		0835:	romdata[15:0] = 16'h3C18;
		0836:	romdata[15:0] = 16'h3C66;
		0837:	romdata[15:0] = 16'hC300;
		0838:	romdata[15:0] = 16'hC366;
		0839:	romdata[15:0] = 16'h3C18;
		0840:	romdata[15:0] = 16'h1818;
		0841:	romdata[15:0] = 16'h1800;
		0842:	romdata[15:0] = 16'hFE0C;
		0843:	romdata[15:0] = 16'h1830;
		0844:	romdata[15:0] = 16'h60C0;
		0845:	romdata[15:0] = 16'hFE00;
		0846:	romdata[15:0] = 16'h3C30;
		0847:	romdata[15:0] = 16'h3030;
		0848:	romdata[15:0] = 16'h3030;
		0849:	romdata[15:0] = 16'h3C00;
		0850:	romdata[15:0] = 16'hC060;
		0851:	romdata[15:0] = 16'h3018;
		0852:	romdata[15:0] = 16'h0C06;
		0853:	romdata[15:0] = 16'h0300;
		0854:	romdata[15:0] = 16'h3C0C;
		0855:	romdata[15:0] = 16'h0C0C;
		0856:	romdata[15:0] = 16'h0C0C;
		0857:	romdata[15:0] = 16'h3C00;
		0858:	romdata[15:0] = 16'h1038;
		0859:	romdata[15:0] = 16'h6CC6;
		0860:	romdata[15:0] = 16'h0000;
		0861:	romdata[15:0] = 16'h0000;
		0862:	romdata[15:0] = 16'h0000;
		0863:	romdata[15:0] = 16'h0000;
		0864:	romdata[15:0] = 16'h0000;
		0865:	romdata[15:0] = 16'h00FE;
		0866:	romdata[15:0] = 16'h1818;
		0867:	romdata[15:0] = 16'h0C00;
		0868:	romdata[15:0] = 16'h0000;
		0869:	romdata[15:0] = 16'h0000;
		0870:	romdata[15:0] = 16'h0000;
		0871:	romdata[15:0] = 16'h3C06;
		0872:	romdata[15:0] = 16'h3E66;
		0873:	romdata[15:0] = 16'h3E00;
		0874:	romdata[15:0] = 16'h6060;
		0875:	romdata[15:0] = 16'h7C66;
		0876:	romdata[15:0] = 16'h6666;
		0877:	romdata[15:0] = 16'h7C00;
		0878:	romdata[15:0] = 16'h0000;
		0879:	romdata[15:0] = 16'h3C60;
		0880:	romdata[15:0] = 16'h6060;
		0881:	romdata[15:0] = 16'h3C00;
		0882:	romdata[15:0] = 16'h0606;
		0883:	romdata[15:0] = 16'h3E66;
		0884:	romdata[15:0] = 16'h6666;
		0885:	romdata[15:0] = 16'h3E00;
		0886:	romdata[15:0] = 16'h0000;
		0887:	romdata[15:0] = 16'h3C66;
		0888:	romdata[15:0] = 16'h7E60;
		0889:	romdata[15:0] = 16'h3C00;
		0890:	romdata[15:0] = 16'h1C30;
		0891:	romdata[15:0] = 16'h7C30;
		0892:	romdata[15:0] = 16'h3030;
		0893:	romdata[15:0] = 16'h3000;
		0894:	romdata[15:0] = 16'h0000;
		0895:	romdata[15:0] = 16'h3E66;
		0896:	romdata[15:0] = 16'h663E;
		0897:	romdata[15:0] = 16'h063C;
		0898:	romdata[15:0] = 16'h6060;
		0899:	romdata[15:0] = 16'h7C66;
		0900:	romdata[15:0] = 16'h6666;
		0901:	romdata[15:0] = 16'h6600;
		0902:	romdata[15:0] = 16'h1800;
		0903:	romdata[15:0] = 16'h1818;
		0904:	romdata[15:0] = 16'h1818;
		0905:	romdata[15:0] = 16'h0C00;
		0906:	romdata[15:0] = 16'h0C00;
		0907:	romdata[15:0] = 16'h0C0C;
		0908:	romdata[15:0] = 16'h0C0C;
		0909:	romdata[15:0] = 16'h0C78;
		0910:	romdata[15:0] = 16'h6060;
		0911:	romdata[15:0] = 16'h666C;
		0912:	romdata[15:0] = 16'h786C;
		0913:	romdata[15:0] = 16'h6600;
		0914:	romdata[15:0] = 16'h1818;
		0915:	romdata[15:0] = 16'h1818;
		0916:	romdata[15:0] = 16'h1818;
		0917:	romdata[15:0] = 16'h0C00;
		0918:	romdata[15:0] = 16'h0000;
		0919:	romdata[15:0] = 16'hECFE;
		0920:	romdata[15:0] = 16'hD6C6;
		0921:	romdata[15:0] = 16'hC600;
		0922:	romdata[15:0] = 16'h0000;
		0923:	romdata[15:0] = 16'h7C66;
		0924:	romdata[15:0] = 16'h6666;
		0925:	romdata[15:0] = 16'h6600;
		0926:	romdata[15:0] = 16'h0000;
		0927:	romdata[15:0] = 16'h3C66;
		0928:	romdata[15:0] = 16'h6666;
		0929:	romdata[15:0] = 16'h3C00;
		0930:	romdata[15:0] = 16'h0000;
		0931:	romdata[15:0] = 16'h7C66;
		0932:	romdata[15:0] = 16'h667C;
		0933:	romdata[15:0] = 16'h6060;
		0934:	romdata[15:0] = 16'h0000;
		0935:	romdata[15:0] = 16'h3E66;
		0936:	romdata[15:0] = 16'h663E;
		0937:	romdata[15:0] = 16'h0606;
		0938:	romdata[15:0] = 16'h0000;
		0939:	romdata[15:0] = 16'h7C66;
		0940:	romdata[15:0] = 16'h6060;
		0941:	romdata[15:0] = 16'h6000;
		0942:	romdata[15:0] = 16'h0000;
		0943:	romdata[15:0] = 16'h3C60;
		0944:	romdata[15:0] = 16'h3C06;
		0945:	romdata[15:0] = 16'h7C00;
		0946:	romdata[15:0] = 16'h3030;
		0947:	romdata[15:0] = 16'h7C30;
		0948:	romdata[15:0] = 16'h3030;
		0949:	romdata[15:0] = 16'h1C00;
		0950:	romdata[15:0] = 16'h0000;
		0951:	romdata[15:0] = 16'h6666;
		0952:	romdata[15:0] = 16'h6666;
		0953:	romdata[15:0] = 16'h3E00;
		0954:	romdata[15:0] = 16'h0000;
		0955:	romdata[15:0] = 16'h6666;
		0956:	romdata[15:0] = 16'h663C;
		0957:	romdata[15:0] = 16'h1800;
		0958:	romdata[15:0] = 16'h0000;
		0959:	romdata[15:0] = 16'hC6C6;
		0960:	romdata[15:0] = 16'hD6FE;
		0961:	romdata[15:0] = 16'h6C00;
		0962:	romdata[15:0] = 16'h0000;
		0963:	romdata[15:0] = 16'hC66C;
		0964:	romdata[15:0] = 16'h386C;
		0965:	romdata[15:0] = 16'hC600;
		0966:	romdata[15:0] = 16'h0000;
		0967:	romdata[15:0] = 16'h6666;
		0968:	romdata[15:0] = 16'h663C;
		0969:	romdata[15:0] = 16'h1830;
		0970:	romdata[15:0] = 16'h0000;
		0971:	romdata[15:0] = 16'h7E0C;
		0972:	romdata[15:0] = 16'h1830;
		0973:	romdata[15:0] = 16'h7E00;
		0974:	romdata[15:0] = 16'h0E18;
		0975:	romdata[15:0] = 16'h1870;
		0976:	romdata[15:0] = 16'h1818;
		0977:	romdata[15:0] = 16'h0E00;
		0978:	romdata[15:0] = 16'h1818;
		0979:	romdata[15:0] = 16'h1818;
		0980:	romdata[15:0] = 16'h1818;
		0981:	romdata[15:0] = 16'h1800;
		0982:	romdata[15:0] = 16'h7018;
		0983:	romdata[15:0] = 16'h180E;
		0984:	romdata[15:0] = 16'h1818;
		0985:	romdata[15:0] = 16'h7000;
		0986:	romdata[15:0] = 16'h729C;
		0987:	romdata[15:0] = 16'h0000;
		0988:	romdata[15:0] = 16'h0000;
		0989:	romdata[15:0] = 16'h0000;
		0990:	romdata[15:0] = 16'hFEFE;
		0991:	romdata[15:0] = 16'hFEFE;
		0992:	romdata[15:0] = 16'hFEFE;
		0993:	romdata[15:0] = 16'hFE00;
		0994:	romdata[15:0] = 16'h0000;
		0995:	romdata[15:0] = 16'h0000;
		0996:	romdata[15:0] = 16'h0000;
		0997:	romdata[15:0] = 16'h0000;
		0998:	romdata[15:0] = 16'h0000;
		0999:	romdata[15:0] = 16'h0000;
		1000:	romdata[15:0] = 16'h0000;
		1001:	romdata[15:0] = 16'h0000;
		1002:	romdata[15:0] = 16'h0000;
		1003:	romdata[15:0] = 16'h0000;
		1004:	romdata[15:0] = 16'h0000;
		1005:	romdata[15:0] = 16'h0000;
		1006:	romdata[15:0] = 16'h0000;
		1007:	romdata[15:0] = 16'h0000;
		1008:	romdata[15:0] = 16'h0000;
		1009:	romdata[15:0] = 16'h0000;
		1010:	romdata[15:0] = 16'h0000;
		1011:	romdata[15:0] = 16'h0000;
		1012:	romdata[15:0] = 16'h0000;
		1013:	romdata[15:0] = 16'h0000;
		1014:	romdata[15:0] = 16'h0000;
		1015:	romdata[15:0] = 16'h0000;
		1016:	romdata[15:0] = 16'h0000;
		1017:	romdata[15:0] = 16'h0000;
		1018:	romdata[15:0] = 16'h0000;
		1019:	romdata[15:0] = 16'h0000;
		1020:	romdata[15:0] = 16'h0000;
		1021:	romdata[15:0] = 16'h0000;
		1022:	romdata[15:0] = 16'h0000;
		1023:	romdata[15:0] = 16'h0000;
	endcase
end

// output enable
always @(romdata or aen or rd)
	if (aen && rd)
		data_out[15:0] = romdata[15:0];
	else
		data_out[15:0] = 16'h0000;

endmodule
