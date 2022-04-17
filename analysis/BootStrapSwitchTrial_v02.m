function [Xtrial] = BootStrapSwitchTrial_v02(Fstate,IDshift,CS)




% find the Xtrial
for block = 1:numel(Fstate(:,1))
    
         thisblock = Fstate(block,20:end);
         
         for crit = 1:20
    
         [start, len, ~] = ZeroOnesCount(thisblock > .5);
        
         try
         Xtrial(block,crit)= start(min(find(len>crit)));
         catch
         Xtrial(block,crit) = NaN;
         end
         
         end
             
%              
    
end % of looping through blocks






end % of function
