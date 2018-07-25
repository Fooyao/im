bid="org.consenlabs.token"
require "TSLib"
width, height = getScreenSize();
UINew(4,"fooyao小工具,转账设置,地址配置,文件配置","开始","取消","im",1,1200,width*0.8,height*0.8,"221,240,237","88,210,232")
UIRadio(1,"功能设置","一对多转账,多对一转账,批量添加合约","1")
UILabel(4,"小号地址文件名（不带后缀）")
UIEdit(4,"adrfile","address.txt就填address","",15,"left","255,0,0")
UILabel(4,"小号私钥文件名（不带后缀）")
UIEdit(4,"syfile","sy.txt就填sy","",15,"left","255,0,0")
UILabel(3,"多对一时固定地址")
UIEdit(3,"gdadress","多对一转账时生效","",15,"left","255,0,0")
UILabel(3,"合约地址")
UIEdit(3,"adress","批量添加合约时生效","",15,"left","255,0,0")
UILabel(1,"钱包密码")
UIEdit(1,"qbmima","钱包密码","QWERqwer.1234",15,"left","255,0,0")
UILabel(2,"转账币种")
UIRadio(2,"币种","ETH,其它","0")
UILabel(2,"自定义币种名称")
UIEdit(2,"bizhong","IM列表怎么显示怎么写,不要符号","",15,"left","255,0,0")
UILabel(2,"转账数量(填写9个9时表示全部)")
UIEdit(2,"shuliang","转账数量","0.0012",15,"left","255,0,0")
UILabel(2,"矿工费设置")
UIRadio(2,"矿工费","默认,最低,自定义","1")
UILabel(2,"自定义矿工费范围")
UIEdit(2,"price1","Price下限","",15,"left","255,0,0","default",width*0.3,"1")
UIEdit(2,"price2","Price上限","",15,"left","255,0,0","default",width*0.3,"0")
UIEdit(2,"gas1","Gas下限","",15,"left","255,0,0","default",width*0.3,"1")
UIEdit(2,"gas2","Gas上限","",15,"left","255,0,0","default",width*0.3,"1")
UILabel(1,[[小号文件一行一个，直接放入电脑]],15,"center")
UILabel(1,[[我的文档\雷电模拟器\Misc文件夹]],15,"center")
UILabel(1,"有问题及时反馈,欢迎扫码捐赠",15,"center")
UIImage("do.jpg","center",0.5)
UIShow()
mSleep(2000)
local ufnvmv=io.open("/storage/emulated/legacy/Misc/p.txt","r")
if ufnvmv then
	ufnvmv:close()
else
	io.open("/storage/emulated/legacy/Misc/p.txt","w"):write("123456789"):close()
end
if 功能设置=="大号批量转小号" then
    if adrfile=="" then
        dialog("小号地址文件名未填写", 0)
    end
elseif 功能设置=="小号批量转固定地址" or 功能设置=="小号批量添加合约" then
    if syfile=="" then
        dialog("小号私钥文件名未填写", 0)
    end
end
function 检测()
if isFrontApp(bid) == 1 then
else 
    r = runApp(bid);
    mSleep(5  * 1000);
    if r == 0 then
    else
        dialog("启动失败",3);
    end
end
end
function movea()
    os.execute("input keyevent 22")
end
function moveb()
	os.execute("input keyevent 20")
	os.execute("input keyevent 20")
	os.execute("input keyevent 20")
	os.execute("input keyevent 20")
	os.execute("input keyevent 20")
end
function click(x,y)
    touchDown(x,y)
    mSleep(50)
    touchUp(x,y)
end
function getxml()
	wjm=os.time()
	os.execute([[uiautomator dump /storage/emulated/legacy/TouchSprite/res/]]..wjm..".xml")
	mSleep(2000)
	repeat
		dumpdumpdumpf=io.open("/storage/emulated/legacy/TouchSprite/res/"..wjm..".xml")
	until(dumpdumpdumpf)
	local d=dumpdumpdumpf:read("*a")
			dumpdumpdumpf:close()
	dumpzuobiao=d:gmatch([[bounds=".-"]])
	dumpbiaoqian=d:gmatch([[text=".-"]])
	local t={}
	local r={}
	local tq=0
	for m in dumpbiaoqian do
		local ty=dumpzuobiao():gmatch([[%d+]])
		local ty1=ty()
		local ty2=ty()
		local c1=math.ceil((ty1+ty())/2)
		local c2=math.ceil((ty2+ty())/2)
		local tx=m:match([[%b""]]):gsub([[%p+]],"")
		if tx == "" then
			tq=tq+1
			r[tq]={c1,c2}
		else
			t[tx]={c1,c2}
		end
	end
	for k1,v1 in ipairs(r) do
		for k2,v2 in ipairs(r) do
			if math.abs(v2[1]-v1[1]) <= 5 and math.abs(v2[2]-v1[2]) <= 5 then
				table.remove(r,k2)
			end
		end
	end
	for k3,v3 in ipairs(r) do
		t[k3]=v3
	end
	os.execute([[rm -rf /storage/emulated/legacy/TouchSprite/res/*.xml]])
	return t
end
function multiColor(array,s)
    s = math.floor(0xff*(100-s)*0.01)
    keepScreen(true)
    for var = 1, #array-1 do
        local lr,lg,lb = getColorRGB(array[var][1],array[var][2])
        local r = math.floor(array[var][3]/0x10000)
        local g = math.floor(array[var][3]%0x10000/0x100)
        local b = math.floor(array[var][3]%0x100)
        if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
            keepScreen(false)
            return false
        end
    end
    keepScreen(false)
    return true
end
function 表找色点击(table)
	for _,i in pairs(table) do
		if multiColor(i,90) then
			click(i[#i][1],i[#i][2])
		end
	end
end
function readtxt(path)
	while (true) do
		local ffff,fqqq=io.open("/storage/emulated/legacy/Misc/p.txt","r")
			if ffff then else dialog(fqqq, 0) end
		local gggg=ffff:read ("*a"):gsub("%s+","")
		if  gggg== "123456789" then
			ffff:close()
			io.open("/storage/emulated/legacy/Misc/p.txt","w"):write("987654321"):close()
			break
		end
		ffff:close()
		mSleep(100)
	end
    local f,fq=io.open(path,"r")
		if f then else dialog(fq, 0) end
    local a=f:read("*l")
    local s= f:read ("*a")
			f:close()
    io.open(path,"w"):write(s):close()
	io.open("/storage/emulated/legacy/Misc/p.txt","w"):write("123456789"):close()
	if a == nil then
		dialog("已全部结束", 0)
		lua_exit()
	else
		return a:gsub("%s+","")
	end
end
取色={
	条款={
    {  183,   65, 0x4e5d6f},
    {  494,   71, 0xb1b7bf},
    {  413,  860, 0xffffff},
    {  387,  918, 0xd6d6d6},
	{  44,853, 0xd6d6d6}
	},
	条款2={
    {  182,   60, 0x626f7f},
    {  495,   71, 0xadb3bb},
    {   43,  855, 0x1eb8d4},
    {  158,  923, 0x36b9c8},
	{  264,923, 0xd6d6d6}
	},
	创建导入={
    {  143,  262, 0x50b4dd},
    {  429,  209, 0x50b4dd},
    {  229,  570, 0xfeffff},
    {  240,  688, 0xd8e6ef},
    {  400,  542, 0x74a6c6},
    {  342,  647, 0x74a6c6},
	{  270,  688, 0xd6d6d6}
	},
	风险评测={
    {  230,   69, 0x4d5d70},
    {  484,   64, 0x38bac9},
    {  356,  729, 0x36b9c8},
    {  373,  817, 0xeff1f2},
    {  234,  476, 0x8c8c8c},
	{  501,   72, 0xd6d6d6}
	},
	助记词导入1={
    {  224,   62, 0x74808e},
    {   45,  137, 0x56c4d1},
    {   47,  174, 0x36b9c8},
    {  284,  763, 0x5dc6d3},
    {  212,  927, 0x3abac9},
	{  337,  135, 0xd6d6d6}
	},
	扫码={
    {   27,   74, 0xb4b9c1},
    {  257,   68, 0x4e5d6f},
    {   85,  353, 0x00ff00},
    {  456,  724, 0x00ff00},
    {  378,  683, 0x242b32},
	{  26,   73, 0xd6d6d6}
	},
	助记词导入2={
	{  225,   63, 0x4e5d6f},
	{  504,   71, 0x606d7e},
	{  516,   82, 0x4e5d6f},
	{   66,  136, 0x36b9c8},
	{  123,  179, 0x36b9c8},
	{  180,  178, 0xcccccc},
	{  118,  134, 0x8fd8e0},
	{  451,  142, 0xd6d6d6}
	},
	崩溃={
    {   47,  407, 0xeeeeee},
    {   75,  430, 0x212121},
    {  211,  488, 0x4e4e4e},
    {  323,  549, 0x009688},
    {  356,  561, 0x009688},
    {  428,  559, 0x63bbb2},
	{  436,  558, 0xd6d6d6}
	},
	崩溃2={
    {   79,  451, 0x858585},
    {  156,  467, 0x1f1f1f},
    {  311,  459, 0x1f1f1f},
    {  421,  528, 0x139d90},
    {  364,  538, 0xeeeeee},
    {  454,  544, 0x86c7c1},
	{  437,  535, 0xd6d6d6}
	},
	找到合约={
    {  451,   59, 0xf1f1f1},
    {  481,   68, 0x84929c},
    {  456,  171, 0x38bac9},
    {  508,  190, 0xccedf1},
    {  342,  935, 0x79d0da},
	{ 472,180, 0xd6d6d6}
	},
	我={
    {   56,  107, 0x36b9c8},
    {  174,  189, 0xdbf2f5},
    {  405,  199, 0x92d9e1},
    {   40,  396, 0x4e5d6f},
    {   42,  554, 0x737e8d},
	{ 148,  182, 0xd6d6d6}
	},
	宣传5={
	{  175,  836, 0x86cfd7},
	{  194,  857, 0x0d9eae},
	{  234,  839, 0x0d9eae},
	{  269,  848, 0x0d9eae},
	{  312,  848, 0x86cfd7},
	{  340,  846, 0x58bcc7},
	{  344,  849, 0x24a6b5},
	{  340,  852, 0x15a0b0},
	{ 255,  846, 0xd6d6d6}
	},
	钱包首页={
	{   29,  887, 0xbababa},
	{   65,  900, 0x27b7d0},
	{   63,  910, 0xa9e0e8},
	{  200,  904, 0x5c6b7e},
	{  207,  917, 0x5a697c},
	{  326,  913, 0x788493},
	{  473,  916, 0x5a697c},
	{ 265,  479, 0xd6d6d6}
	}
}

资产页={
	{    1,  885, 0x36b9c8},
	{  100,  905, 0x4ac0cd},
	{  101,  916, 0x79d1da},
	{  270,  924, 0x046fb8},
	{  368,  914, 0x8c96cf},
	{  417,  926, 0xb0d2e9},
	{  535,  885, 0x046fb8},
}
转账页面={
	{  492,  143, 0x36b9c8},
	{  156,  777, 0x36b9c8},
	{  519,   71, 0x606d7e},
	{  508,  135, 0x60c7d3},
}

已有相同交易={
	{  253,  613, 0xeeeeee},
	{  258,  695, 0x666666},
	{  209,  905, 0x164a50},
}
宣传1={
	{  209,  853, 0x37aab8},
	{  235,  851, 0xebeced},
	{  255,  852, 0xebeced},
	{  280,  853, 0xebeced},
	{  298,  854, 0xebeced},
}
宣传2={
	{  211,  853, 0xebeced},
	{  233,  853, 0x37aab8},
	{  254,  853, 0xebeced},
	{  278,  854, 0xebeced},
	{  299,  854, 0xebeced},
}
宣传3={
	{  210,  854, 0xebeced},
	{  235,  852, 0xebeced},
	{  253,  852, 0x37aab8},
	{  281,  853, 0xebeced},
	{  299,  852, 0xebeced},
}
宣传4={
	{  208,  852, 0xebeced},
	{  232,  853, 0xebeced},
	{  254,  855, 0xebeced},
	{  278,  850, 0x37aab8},
	{  301,  852, 0xebeced},
}
私钥导入1={
    {  234,   69, 0x4e5d6f},
    {  324,  133, 0x56c4d1},
    {  356,  137, 0x36b9c8},
    {  329,  175, 0x36b9c8},
    {  255,  841, 0x77d0da},
}
交易密码不正确={
	{   79,  421, 0x1f1f1f},
	{  176,  430, 0x232323},
	{  248,  435, 0x9e9e9e},
	{  132,  489, 0x1f1f1f},
	{  132,  503, 0x1f1f1f},
	{  133,  503, 0x646464},
	{  423,  566, 0x4fb3aa},
	{  439,  566, 0x009688},
	{  447,  576, 0x0b9a8d},
	{  447,  562, 0x0a998c},
}
地址错误={
	{   81,  444, 0x1f1f1f},
	{  170,  483, 0x1f1f1f},
	{  234,  485, 0x1f1f1f},
	{  423,  543, 0x08998b},
	{  445,  539, 0x009688},
	{  407,  449, 0x1f1f1f},
	{  408,  450, 0x616161},
	{  406,  450, 0x5b5b5b},
}
私钥导入2={
	{  433,  127, 0x36b9c8},
	{  462,  138, 0x36b9c8},
	{  451,  176, 0x36b9c8},
	{  359,  178, 0xcccccc},
	{  500,   71, 0x606d7e},
	{  276,   77, 0x4e5d6f},
}
私钥导入3={
	{   26,  179, 0xcccccc},
	{  190,  178, 0xcccccc},
	{  307,  178, 0x36b9c8},
	{  475,  178, 0xcccccc},
}
导入成功={
    {   27,   73, 0xe0e2e5},
    {   34,  896, 0x36b9c8},
    {  315,  903, 0x046fb8},
    {   79,  914, 0x89d6de},
    {  349,  927, 0x004aa6},
}

添加资产={
    {   27,   71, 0xf8f9f9},
    {  237,   71, 0x4e5d6f},
    {  324,   61, 0x4e5d6f},
    {  487,   66, 0x92979b},
    {  514,   85, 0xa6a9ad},
    {   63,  162, 0x656690},
}
高级选项={
	{  495,  699, 0x36b9c8},
	{  458,  697, 0x36b9c8},
	{  411,  790, 0x36b9c8},
}
搜索={
	{  254,  298, 0xd8d8d8},
	{  186,  389, 0xb0b5b8},
	{  356,  389, 0xe1e2e3},
	{  360,  427, 0x9ea4a8},
	{  183,  934, 0x62c8d4},
	{  195,  934, 0x82d3dd},
	{  280,  931, 0x3abac9},
	{  311,  931, 0x36b9c8},
}
添加成功={
    {  463,   62, 0xffffff},
    {  446,   72, 0xb4b6b8},
    {  485,   68, 0x929ea7},
    {  458,  170, 0xaaafb3},
    {  480,  173, 0xb5babd},
    {  501,  181, 0x9ea4a8},
}
无效的私钥={
    {   48,  404, 0x666666},
    {   50,  424, 0xeeeeee},
    {   79,  449, 0x9a9a9a},
    {  117,  454, 0x1f1f1f},
    {  433,  535, 0x009688},
    {  447,  528, 0x0a998c},
}
钱包超限={
    {   37,  404, 0x666666},
    {   78,  449, 0x747474},
    {  111,  459, 0x1f1f1f},
    {  261,  463, 0x363636},
    {  423,  532, 0x4fb3aa},
    {  446,  540, 0x009688},
}

转账确认={
    {   33,  366, 0xd5d8dc},
    {  233,  368, 0x5a697c},
    {   67,  876, 0x36b9c8},
    {  282,  896, 0xd4f0f3},
    {   63,  933, 0xffffff},
    {  298,  581, 0xececec},
}
钱包密码页面={
    {   28,  368, 0xd4d7db},
    {  243,  370, 0x5a697c},
    {   67,  883, 0x36b9c8},
    {  263,  900, 0xffffff},
	{  265,  857, 0xffffff},
    {  240,  694, 0xffffff},
}
ETH不足={
	{   75,  451, 0x1f1f1f},
	{   85,  451, 0x4d4d4d},
	{   84,  458, 0x777777},
	{   94,  467, 0x1f1f1f},
	{   94,  467, 0x1f1f1f},
	{   98,  451, 0x1f1f1f},
	{  165,  468, 0x1f1f1f},
	{  169,  461, 0x939393},
	{  423,  533, 0x23a397},
	{  438,  533, 0x60b9b1},
}

	apath="/storage/emulated/legacy/Misc/"..syfile..".txt"
	bpath="/storage/emulated/legacy/Misc/"..adrfile..".txt"
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	次数=0
	转账成功=false
	keep=1
	inputtt=0
	inputxx=0
	转账成功=false
function 清理()
	closeApp(bid)
	cleanApp(bid)
	mSleep(2000)
end
function 大号批量转小号eth()
while true do
    检测()
	表找色点击(取色)
    if  multiColor(资产页,90) then
        nLog("在资产页")
        click(137,  926) --点击转账
		inputtt=0
		mSleep(500)
    end
    if multiColor(崩溃,90) then
        click(436,  558)
		inputtt=0 
    end
    if multiColor(崩溃2,90) then
        click(437,  535)
		inputtt=0 
    end
    if  multiColor(转账页面,90) then
        if inputtt==0 then
			click(199,144) --点击钱包地址
			local asdasdasd="input text "..readtxt(bpath):sub(1,42)
			os.execute(asdasdasd)
			mSleep(1000)
			click( 101,  218) --点击金额
			mSleep(500)
			inputText(shuliang)
			mSleep(500)
			if 矿工费 == "最低" then
				click( 47,  434) --点击最低
				mSleep(500)
				click( 47,  434)
				mSleep(500)
			elseif 矿工费 == "自定义" then
				click( 481,  696) --点击高级选项
				repeat
					mSleep(500)
				until (multiColor(高级选项,90))
				mSleep(500)
				click( 115,371) --点击PRICE
				mSleep(500)
				inputText(math.random(price1*100,price2*100)/100)
				mSleep(500)
				click(81,438) --点击gas
				click(81,438) --点击gas
				mSleep(500)
				inputText(math.random(gas1,gas2))
				mSleep(1000)
			end
			inputtt=1
		end
        click( 273,  795) --点击下一步
		mSleep(500)
    end
    if multiColor(转账确认,90) then
		inputtt=0
        click(264,  897)
		mSleep(500)
    end
    if multiColor(钱包密码页面,90) and 转账成功==false then
        click(440,487) 
        mSleep(500)
		for a=1,16 do
			os.execute("input keyevent 67")
		end
        mSleep(1000)
		inputText(qbmima)
		nLog(qbmima)
        mSleep(1000)
        click(268,896)
        mSleep(5000)
		转账成功=true
    end
	if 转账成功 then
		while true do
			local ssss=getxml()
			if ssss["密码不正确"] then
				click(432,570)
				break
			end
			if ssss["交易序列号 Nonce 值太低"] then
				click(435,570)
				break
			end
			if ssss["已经有相同的交易，如果想替换，请提高 gas price，注意双重支付的风险！"] then
				click(435,587)
				for i= 60,0,-5 do
					toast("交易冲突，"..i.."秒后尝试下一次转账",2)
					mSleep(5000)
				end
				break
			end
			if  multiColor(资产页,90) then
				break
			end
			mSleep(5000)
		end
		转账成功=false
	end
end
end
function 导入()
	if multiColor(宣传1,90) or multiColor(宣传2,90) or multiColor(宣传3,90) or multiColor(宣传4,90) then
        movea()
    end
    if multiColor(私钥导入1,90) or multiColor(私钥导入2,90) then
        if inputxx==0 then
			mSleep(500)
			click( 115,275) ---点击私钥输入框
			click( 115,275) ---点击私钥输入框
			mSleep(500)
			local sssyyy=readtxt(apath)
			inputText(sssyyy)
			mSleep(1000)
			click( 59,435) ---点击密码框
			mSleep(500)
			inputText(qbmima)
			mSleep(1000)
			click(  70,  559) ---点击再次密码框
			mSleep(500)
			inputText(qbmima)
			mSleep(500)
			inputxx=1
		end
        click(  43,  710) ---勾选协议
        mSleep(500)
        click(  264,  772) ---点击导入
        mSleep(2000)
        keep=0
    end
    if multiColor(导入成功,90) then
		inputxx=0
        if keep==0 then
            nLog("点击返回")
            click(26,70)
        else 
            nLog("点击导入")
            click(418,920)
        end
    end
end

function 小号批量添加合约啊()
while true do
    检测()
	表找色点击(取色)
    导入()
    if multiColor(钱包首页,90) then
        if keep==0 then
            click(480,  356) --点击加号
        else 
            click(472,  916) ---点击我的
        end
    end
    if multiColor(添加资产,90) then
        if keep==0 then
            click(502,   74) --点击放大镜
        else
            click( 30,   71) --点击返回
        end
    end
    if multiColor(搜索,90) then
        click(193,70)
        mSleep(500)
		inputText(adress)
		mSleep(3000)
    end

    if multiColor(无效的私钥,90) then
        click(436, 534)
        mSleep(500)
        click( 29,71)
    end
    if multiColor(钱包超限,90) then
        closeApp(bid);
        cleanApp(bid)
        mSleep(2000)
		keep=1
        次数=0
    end
    if multiColor(添加成功,90) then
        次数=次数+1
        click( 497,   76)
        keep=1
		inputxx=0
        nLog("成功次数"..次数)
        if 次数 == 10 then
            closeApp(bid);
            cleanApp(bid)
            次数=0
        end
        mSleep(2000)
    end
end
end

function 小号批量转固定地址eth(  )
while true do
    检测()
	表找色点击(取色)
    导入()
    if multiColor(钱包首页,90) then
        if keep==0 then
			if 币种=="ETH" then
				click(265,  479) --点击ETH
			else
				qweasda=0
				for dsda=1,5 do
					s=getxml()
					if s[bizhong] then
						click(s[bizhong][1],s[bizhong][2])
						qweasda=1
						break
					else
						
					end
					moveb()
				end
				if qweasda==0 then
					click(472,  916) ---点击我的
					keep=1
				end
			end
        else 
            click(472,  916) ---点击我的
        end
    end
    if multiColor(我,90) then
        click(148,  182)
    end
    if  multiColor(资产页,90) then
		if keep==0 then
			nLog("资产页")
			if shuliang == "999999999" then
				local sasas=getxml()
				for k,v in pairs(sasas) do
					if v[1]==270 and v[2]==156 then
						钱币=tonumber(k)/10000
						break
					end
				end
			end
			click( 148,  920) --点击转账
		else
			click(27,73)
		end
    end
	if  multiColor(ETH不足,90) then
        click(437,535) --点击OK
		mSleep(500)
		click(33,71) --点击x
		mSleep(500)
		click(33,71) --点击x
		keep=1
		io.open("/storage/emulated/legacy/Misc/ETH不足.txt","w"):write(sssyyy.."\r\n"):close()
    end
    if multiColor(钱包超限,90) then
		io.open(bpath,"a"):write("\r\n"..sssyyy):close()
		清理()
        次数=0
		keep=1
    end
    if  multiColor(转账页面,90) then
		if inputtt==0 then
			mSleep(500)
			click(134,143) --点击钱包地址
			mSleep(100)
			click(134,143) --点击钱包地址
			mSleep(500)
			inputText(gdadress)
			mSleep(1000)
			click( 101,  218) --点击金额
			mSleep(500)
			if shuliang == "999999999" then
				inputText(钱币)
			else
				inputText(shuliang)
			end
			mSleep(500)
			if 矿工费 == "最低" then
				click( 47,  434) --点击最低
				mSleep(500)
				click( 47,  434)
				mSleep(500)
			elseif 矿工费 == "自定义" then
				click( 481,  696) --点击高级选项
				repeat
					mSleep(500)
				until (multiColor(高级选项,90))
				mSleep(500)
				click( 115,371) --点击PRICE
				mSleep(500)
				inputText(math.random(price1,price2))
				mSleep(500)
				click(81,438) --点击gas
				click(81,438) --点击gas
				mSleep(500)
				inputText(math.random(gas1,gas2))
				mSleep(1000)
			end
			inputtt=1
		end
        click( 273,  795) --点击下一步
    end
	if multiColor(地址错误,90) then
        click(436,543)
        mSleep(1000)
        click( 29,71)
		inputtt=0
    end
    if multiColor(无效的私钥,90) then
        click(436, 534)
        mSleep(500)
        click( 29,71)
		keep=0
		io.open("/storage/emulated/legacy/Misc/无效私钥.txt","w"):write(sssyyy.."\r\n"):close()
    end
    if multiColor(转账确认,90) then
		inputtt=0
        click(264,  897) 
    end
    if multiColor(钱包密码页面,90) and 转账成功==false then
        click(140,  487) 
        mSleep(500)
        for a=1,16 do
			os.execute("input keyevent 67")
		end
        mSleep(1000)
		inputText(qbmima)
        mSleep(1000)
        click(268,896)
        if 次数 == 10 then
            清理()
            次数=0
        end
        mSleep(5000)
		转账成功=true
		inputxx=0
		keep=1
    end
	if 转账成功 then
		time0=os.time()
		while true do
			local ssss=getxml()
			if ssss["密码不正确"] then
				click(432,570)
				break
			end
			if ssss["交易序列号 Nonce 值太低"] then
				click(435,570)
				break
			end
			if ssss["已经有相同的交易，如果想替换，请提高 gas price，注意双重支付的风险！"] then
				click(435,587)
				for i= 60,0,-5 do
					toast("交易冲突，"..i.."秒后尝试下一次转账",2)
					mSleep(5000)
				end
				break
			end
			if  multiColor(资产页,90) then
				次数 =次数 + 1
				break
			end
			mSleep(5000)
		end
		转账成功=false
	end
end
end
if 功能设置=="一对多转账" then
    大号批量转小号eth()
elseif 功能设置=="多对一转账" then
	清理()
    小号批量转固定地址eth()
elseif 功能设置=="批量添加合约" then
	清理()
    小号批量添加合约啊()
end
