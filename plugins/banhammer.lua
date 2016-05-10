local action = function(msg, blocks, ln)
	if msg.chat.type ~= 'private' then
		if is_mod(msg) then
		    if not msg.reply_to_message and not blocks[2] then
		        api.sendReply(msg, lang[ln].banhammer.reply)
		        return nil
		    end
		    if msg.reply and msg.reply.from.id == bot.id then
		    	return
		    end
		 	local res
		 	if blocks[1] == 'kick' then
		    	api.kickUser(msg, true, false, blocks[2])
		    	mystat('/kick')
	    	end
	   		if blocks[1] == 'ban' then
	   			api.banUser(msg, true, false, blocks[2])
	   		--	api.sendSticker(msg.chat.id, './stickers/banned.webp')

		   		mystat('/ban')
    		end
   			if blocks[1] == 'unban' then
   				api.unbanUser(msg, true, false, blocks[2])
   				mystat('/unban')
   			end
   			if blocks[1] == 'gban' then
	   			if is_admin(msg) then
	   				local groups = client:smembers('bot:tofix')
    				local succ = 0
    				local not_succ = 0
	    			for k,v in pairs(groups) do
	    				local res = api.banUser(msg, true, false, blocks[2])
	    				if res then
	    					print('Global banned', v)
	   						succ = succ + 1
	   					else
	   						print('Not banned', v)
	   						not_succ = not_succ + 1
    					end
    				end
    				api.sendMessage(msg.chat.id, make_text(lang[ln].banhammer.globally_banned, name)..'\nDone: '..succ..'\nErrors: '..not_succ)
    				mystat('/gban')
    			end
    		end
		end
	else
    	api.sendMessage(msg.chat.id, lang[ln].pv)
	end
end

return {
	action = action,
	triggers = {
		'^/(kick)$',
		'^/(kick) (@[%w_]+)$',
		'^/(ban)$',
		'^/(ban) (@[%w_]+)$',
		'^/(unban)$',
		'^/(unban) (@[%w_]+)$',
		'^/(gban)$'
	--	'^/(gban) (@[%w_]+)$',
	}
}
