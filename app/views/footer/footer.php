<footer>
	<div class="chat_bar">
		<div class="chats">
			<div class="list">
				<div class="chat">
					<div class="box" style="display: none;">
						<div class="header">
							<span class="status"><?= Asset::img('icons/online_white.png'); ?></span><h4>Roy Hibbert</h4>
							<span class="close_chat">X</span>
							<span class="minimize_chat">_</span>
						</div>
						<div class="conversation">
							<div class="received">
								<h4>Roy Hibbert</h4><span class="timestamp">11:33PM</span>
								<p>I’ll be better next year I promise I’ll hit the boards for more rebounds. I’ll practice all summer long. Just me another chance.</p>
							</div>
							<div class="sent">
								<h4>Andrew Luck</h4><span class="timestamp">11:36PM</span>
								<p>Nah... bro you sucked. Indiana doesn’t want to hear your excuses!</p>
							</div>
							<div class="received">
								<h4>Roy Hibbert</h4><span class="timestamp">11:37PM</span>
								<p>You'll regret it!</p>
							</div>
						</div>
						<div class="textbox">
							<textarea placeholder="Type a message..." style="resize: none;"></textarea>
						</div>
					</div>
					<div class="user">
						<span class="status"><?= Asset::img('icons/online_white.png'); ?></span><h4>Roy Hibbert</h4>
						<!-- <span class="notifications" style="display: none;">3</span> -->
					</div>
				</div>
				<div class="chat">
					<div class="box" style="display: none;">
						<div class="header">
							<span class="status"><?= Asset::img('icons/online_white.png'); ?></span><h4>Peyton Manning</h4>
							<span class="close_chat">X</span>
							<span class="minimize_chat">_</span>
						</div>
						<div class="conversation">
							
						</div>
						<div class="textbox">
							<textarea placeholder="Type a message..." style="resize: none;"></textarea>
						</div>
					</div>
					<div class="user">
						<span class="status"><?= Asset::img('icons/online_white.png'); ?></span><h4>Peyton Manning</h4>
						<span class="notifications">3</span>
					</div>
				</div>
			</div>
		</div>
		<div class="power">
			<h3 class="on">CHAT ON</h3>
			<h3 class="off" style="display: none;">CHAT OFF</h3>
		</div>
		<div class="my_status">
			<div class="status_list">
				
			</div>
			<div class="current_status">
				<h3>AVAILABLE</h3><span><?= Asset::img('icons/online_white.png'); ?></span>
			</div>
		</div>
		<div class="contacts">
			<h3>CONTACTS</h3>
		</div>
	</div>	
</footer>