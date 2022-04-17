function [outdata] = GetWSorLS_v01(HitIX,Cond1,Cond2)
outdata=[];



   s1v2_hit = find(HitIX & Cond1 & Cond2);
    s1v2     = find(Cond1 & Cond2);
    
    for t = 1:numel(s1v2_hit)-1
        
        tnum = s1v2_hit(t);
        tmp_s1v2 = s1v2(s1v2 > tnum);
        
        t_WS(t) = HitIX(tmp_s1v2(1));
        
    end % of looping through trials
    
    outdata = mean(t_WS);


end % of function