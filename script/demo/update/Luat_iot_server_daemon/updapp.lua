require"update"
module(...,package.seeall)

local retry = 0

local function upevt(ind,para)
	--���������°汾
	if ind == "NEW_VER_IND" then		
		--���������°汾
		para(true)
	--���ؽ���
	elseif ind == "UP_END_IND" then
		if para then
			sys.restart("updapp suc")
		else
			if retry<3 then
				sys.timer_start(update.request,5000)
				retry = retry+1
			else
				sys.restart("updapp fail")
			end
		end
	end
end

local procer =
{
	UP_EVT = upevt,
}

sys.regapp(procer)
sys.timer_start(sys.restart,300000,"updapp timeout")