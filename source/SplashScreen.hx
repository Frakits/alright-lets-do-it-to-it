package;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.tweens.FlxTween;
import flixel.effects.FlxFlicker;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;

class SplashScreen extends MusicBeatState {
	var curSelection:Int = 13;
	var curPage:FlxSpriteGroup = null;

	var pages:Array<FlxSpriteGroup> = [];
	var scrollableText:Array<Dynamic> = [];
	var scrolled:Float = 0;
	var maxScrolled:Float = 0;
	var buttons:Array<FlxText> = [];

	var keybindButtons:Array<FlxSpriteGroup> = [];

	var canProceed:Bool = true;

	var imRealFuckingLazyNow:Dynamic = {};

	override function create() {
		super.create();

		var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
		diamond.persist = true;
		diamond.destroyOnNoUse = false;

		FlxTransitionableState.defaultTransIn = new TransitionData(FADE, 0xFF000000, 1, new flixel.math.FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
			new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
		FlxTransitionableState.defaultTransOut = new TransitionData(FADE, 0xFF000000, 0.7, new flixel.math.FlxPoint(0, 1),
			{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		pages.push((() -> { // page 1: epilepsy
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: EPILEPTIC CONTENT.");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "A small percentage of people may experience seizures or loss of consciousness when exposed to certain visual images, flashing lights, patterns, or backgrounds, including while playing video games. These seizures may occur even if a person has no prior history of seizures or epilepsy.\n\nStop playing immediately and consult a doctor if you experience any symptoms such as dizziness, altered vision, eye or muscle twitching, loss of awareness, disorientation, involuntary movement, or convulsions.\n\nIf you have a history of seizures or epilepsy, or if you are unsure, consult a doctor before playing. Parents and guardians should supervise children and monitor for these symptoms.\n\nTo reduce risk, play in a well-lit room, sit as far from the screen as comfortable, take regular breaks, and stop playing if you feel unwell.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 2: copyright
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: TRADEMARKS.");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This Mod is an independent, unofficial, fan-made project created for entertainment purposes.\n\nAll names, characters, locations, music, artwork, dialogue, logos, trademarks, and other elements that originate from Sonic the Hedgehog, Sonic Boom, Sonic the Hedgehog CD, Sonic the Hedgehog 4, Sonic Forces (collectively, the “Third-Party IP”) are the property of their respective owners. The Mod is not sponsored, endorsed, licensed, or approved by, and is not affiliated with, SEGA, Sonic Team, Headcannon or any of its affiliates.\n\nNo challenge to the ownership, validity, or enforceability of the Third-Party IP is intended. Any use of Third-Party IP is made in good faith to acknowledge and celebrate the original work.\n\nThis disclaimer does not grant any rights in the Third-Party IP, and it does not limit any rights of the respective owners.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);

			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 3: dark themes
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: DARK/EMOTIONAL THEMES.");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This mod contains story content that some players may find disturbing or emotionally difficult, including references to Depression, Anxiety, Self-harm, Suicidal Ideation, Abuse, Trauma, Grief, Addiction and so much more. These themes are presented for narrative purposes.\n\nPlayer discretion is advised. If you feel distressed at any time, please stop playing and consider seeking support from a trusted person or a qualified professional.\n\nIf you or someone you know may be at risk of self-harm, seek immediate help from local emergency services or a crisis hotline in your area.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 4: hand strain
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: REPETITIVE STRAIN/CARPEL TUNNEL");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "Playing video games may involve repetitive motions and sustained hand, wrist, arm, neck, or shoulder positions that can cause discomfort or contribute to repetitive strain injuries (RSI), including tendonitis and carpal tunnel syndrome.\n\nStop playing immediately if you experience pain, numbness, tingling, weakness, or discomfort in your hands, wrists, arms, shoulders, neck, or back. Do not play through pain. If symptoms persist or worsen, consult a qualified healthcare professional.\n\nTo reduce risk, take regular breaks, stretch periodically, use a comfortable posture and setup, and adjust control settings to your comfort level.\n\nThe Mod is provided “as is” for entertainment purposes only. To the maximum extent permitted by applicable law, the developer/publisher disclaims liability for any injury, discomfort, or health issues arising from or related to playing the Mod or using any associated hardware, including any RSI or carpal tunnel-related issues.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 5: motion sickness
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: MOTION SICKNESS");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "Some players may experience motion sickness, nausea, dizziness, headaches, eyestrain, disorientation, or other discomfort while playing video games, especially those featuring fast movement, screen shaking, camera effects, or certain field-of-view (FOV) settings.\n\nStop playing immediately if you feel unwell. Take a break and rest until symptoms pass. If symptoms are severe, recurring, or persist, consult a qualified healthcare professional.\n\nTo reduce the risk of motion sickness, consider playing in a well-lit room, sitting farther from the screen, taking regular breaks, and adjusting settings such as FOV, camera sensitivity, motion blur, head bob, screen shake, and other visual effects, if available.\n\nThe Mod is provided for entertainment purposes only. To the maximum extent permitted by applicable law, the developer/publisher disclaims liability for any motion sickness or related symptoms arising from or connected to playing the Mod.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 6: color blindness
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: COLOR VISION DEFICIENCY");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This mod relies on color-based information and visual cues for core gameplay. As a result, players with color vision deficiency (including red–green, blue–yellow, or total color blindness) may have difficulty distinguishing certain elements and may not be able to play the mod properly or complete it.\n\nThe mod is provided “as is.” At this time, we do not guarantee full accessibility or compatibility for color vision deficiency, and we disclaim responsibility for any inability to play, reduced performance, or negative experience resulting from color-based gameplay elements.\n\nIf you are affected by color vision deficiency, please consider this warning before purchase or download.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 7: audio dependent
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: AUDIO-DEPENDENT GAMEPLAY");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This game is designed around audio and includes important information delivered through sound (including dialogue, music, and/or audio cues). As a result, players who are deaf or hard of hearing, or players who cannot use audio, may be unable to experience the mod as intended and may have difficulty progressing or completing certain parts of the mod.\n\nThe mod is provided “as is.” At this time, we do not guarantee full accessibility without sound (including subtitles, captions, or visual alternatives for audio cues). To the maximum extent permitted by applicable law, the developer/publisher disclaims liability for any inability to play, reduced experience, or loss arising from the absence of audio access.\n\nPlease consider this notice before purchase or download if you require full audio accessibility.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 8: visual dependent
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: VISUAL-DEPENDENT GAMEPLAY");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This mod is primarily visual and requires the player to see on-screen text, graphics, and visual cues to play. As a result, players who are blind or have significant visual impairments may be unable to access, play, or experience the mod as intended.\n\nThe mod is provided “as is.” At this time, we do not guarantee accessibility features such as screen-reader support, audio description, high-contrast modes, scalable UI, or other accommodations for blind or low-vision players. To the maximum extent permitted by applicable law, the developer/publisher disclaims liability for any inability to play, reduced experience, or loss arising from the mod’s visual requirements.\n\nPlease consider this notice before purchase or download if you require full visual accessibility.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 9: stylization
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: STYLIZATION & TASTE");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "This mod features a deliberate, highly stylized artistic and narrative presentation (including its visuals, animation, audio, tone, and/or gameplay design). Because personal preferences vary, this style may not appeal to all players.\n\nBy downloading or playing the mod, you acknowledge that enjoyment and suitability are subjective and that the mod may not meet individual expectations regarding look, feel, tone, or presentation.\n\nThe mod is provided “as is.” To the maximum extent permitted by applicable law, the developer/publisher disclaims liability for dissatisfaction, disappointment, or any perceived lack of suitability arising from the mod’s stylized nature.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 10: stylization 2
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: MUSIC & TASTE");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "The music and audio content featured in this Mod spans a variety of genres, styles, and tones, and has been selected to complement the overall experience. However, we acknowledge that musical taste is deeply personal, and not all tracks may appeal to every player.\n\nSome music featured in this Mod may include, but is not limited to, genres or styles that certain players may find unfamiliar, repetitive, or not to their personal preference. We encourage players who find the music unsuitable for their enjoyment to make use of the in-game audio settings to adjust or mute the music at their discretion.\n\nThe music featured in this Mod is used under the appropriate licenses, permissions, or falls under fair use where applicable. All rights to the respective tracks remain with their original composers, artists, and rights holders. No claim of ownership is made over any third-party music used within this Mod.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 11: ships
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: FICTIONAL SHIPS & ROMANTIC PAIRINGS");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "The romantic pairings, relationships, and \"ships\" depicted or referenced in this Mod are entirely fictional and created purely for entertainment purposes. We acknowledge that fan-created ships and romantic interpretations of characters are a deeply personal matter, and not every pairing featured will resonate with every player.\n\nSome players may find certain ships unexpected, unconventional, or simply not to their taste, and we fully respect that. If any depicted romantic pairings are not to your preference, we encourage you to engage with the content that you do enjoy and set aside what does not appeal to you.\n\nWe have made every effort to present these fictional pairings in a way that is respectful to both the characters and the players experiencing them. Player reception will naturally vary, and we appreciate your open-mindedness in engaging with the creative choices made throughout this Mod.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 12: sonic
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "WARNING: SONIC'S APPEARANCE");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "The depiction of Sonic the Hedgehog featured in this Mod represents one creative interpretation of the character and is not intended to serve as a definitive or official representation of his design. As with any fan-created or stylized content, artistic choices have been made that may differ from what players are accustomed to or prefer.\n\nWe are aware that certain aspects of Sonic's appearance, including but not limited to the size and shape of his quills, may not align with every player's personal expectations or preferences. Character design is a subjective matter, and we fully respect that some players may feel strongly about specific visual details.\n\nWe appreciate your understanding and patience with the artistic direction taken in this Mod. If certain design choices are not to your liking, we encourage you to focus on the aspects of the experience that you do enjoy, and we thank you for giving our interpretation of the character a chance.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			page.add(text);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 13: eula
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "END USER AGREEMENT");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "END USER AGREEMENT (EUA)\nThat One Sonic Mod\nLast Updated: [Insert Date]\n\nThis End User Agreement (\"Agreement\") governs your access to and use of the modification known as \"That One Sonic Mod\" (the \"Mod\"). By downloading, installing, or using the Mod, you (\"User\") agree to be bound by the following terms.\n\n\nSECTION 1. ACCEPTANCE OF TERMS\n\nBy proceeding, the User confirms that they have read and understood this Agreement in full, accept all terms and conditions stated herein, and acknowledge the Mod's intentional blending of standard software practices with fictional narrative elements. If the User does not agree, they must immediately cease use and remove all copies of the Mod from their system.\n\n\nSECTION 2. LICENSE GRANT\n\nThe Mod is licensed, not sold. The User is granted a limited, revocable, non-exclusive, non-transferable license to install and use the Mod for personal, non-commercial purposes, and to access all included audiovisual and interactive features. No ownership rights are transferred under this Agreement. The creators retain all intellectual property rights associated with the Mod and its contents.\n\n\nSECTION 3. RESTRICTIONS\n\nThe User shall not modify, reverse engineer, decompile, or disassemble the Mod in whole or in part. The User shall not redistribute or commercially exploit any part of the Mod, extract assets including audio, visuals, scripts, or data structures, or interfere with intended behaviors, triggers, or scripted events. Attempts to bypass, circumvent, or manipulate any system within the Mod are strictly prohibited. Violation of any restriction set forth in this section results in immediate termination of this Agreement and all rights granted herein.\n\n\nSECTION 4. CONTENT AND EXPERIENCE NOTICE\n\nThe User acknowledges that the Mod may include visual distortion, flickering imagery, and rapid transitions, as well as dynamic audio variations and irregular timing cues. The Mod is designed to include events that disrupt player expectation and perception. Certain narrative sequences may create the impression of direct communication or observation. These elements are intentional and form part of the Mod's creative direction. The User accepts full responsibility for engaging with such content.\n\n\nSECTION 5. UPDATES AND REVISIONS\n\nThe creators reserve the right to update or modify the Mod at any time without prior notice. New systems, behaviors, or narrative elements may be introduced at the creators' discretion. Continued use of the Mod following any update constitutes acceptance of all changes made.\n\n\nSECTION 6. TERMINATION\n\nThis Agreement remains in effect until terminated. Failure to comply with any term outlined in this Agreement will result in immediate revocation of all rights granted herein. Upon termination, the User must delete all copies of the Mod and any associated files from their system.\n\n\nSECTION 7. DISCLAIMER OF WARRANTIES\n\nThe Mod is provided \"as is,\" without warranty of any kind, express or implied. The creators disclaim all liability for software performance issues, compatibility limitations, unexpected gameplay outcomes, and any other technical or experiential irregularities. Use of the Mod is at the User's sole risk.\n\n\nSECTION 8. LIMITATION OF LIABILITY\n\nTo the fullest extent permitted by applicable law, the creators shall not be liable for indirect or consequential damages, loss of data or system instability, or emotional, psychological, or physiological responses to the Mod's content. The creators shall not be held responsible for any outcomes arising from the User's willful engagement with the Mod's immersive and disorienting elements.\n\n\nSECTION 9. GOVERNING TERMS\n\nThis Agreement constitutes the entire understanding between the User and the creators with respect to the Mod. Any prior agreements, representations, or understandings, whether written or oral, are superseded by this document. If any provision of this Agreement is found to be unenforceable, the remaining provisions shall continue in full force and effect.\n\n\n----------------------------------------------------------------\n\n\nTERMS OF SERVICE (TOS)\nSystem Interaction and Narrative Data Policy\nThat One Sonic Mod\n\n\nSECTION 1. OVERVIEW\n\nThis Terms of Service outlines how the Mod simulates interaction with user data as part of its narrative and gameplay systems. These terms are intended to provide transparency regarding the Mod's internal processes and the fictional framework within which certain data-related language is used. Users are encouraged to read this document carefully before proceeding.\n\n\nSECTION 2. SIMULATED DATA COLLECTION\n\nDuring gameplay, the Mod may simulate the collection of input timing and key presses, performance metrics and accuracy scores, session-based interaction patterns, and response latency across various gameplay events. These simulated systems exist solely to enhance gameplay and narrative immersion. No information gathered through these processes is transmitted to any external server, individual, or third party.\n\n\nSECTION 3. THE \"pizzapwner\" ENTITY\n\nWithin the context of the Mod's narrative, pizzapwner is presented as a supervisory presence tied to the Mod's internal systems, a fictionalized authority overseeing gameplay behavior and progression, and a meta-character used to frame certain adaptive or reactive features of the experience.\n\nReferences to pizzapwner throughout the Mod may include system messages or formal acknowledgments, implied observation of gameplay performance and user decision-making, narrative suggestions of awareness, oversight, or ongoing attention, and language designed to create the impression of a persistent and attentive presence.\n\nThe User may at various points feel observed. This is intentional.\n\nClarification: All references to pizzapwner as an observing or data-collecting entity are purely fictional and part of the Mod's artistic design. They do not represent real-world monitoring, data access, surveillance, or tracking of individual activity in any form. pizzapwner is not a real person, organization, or automated system operating outside the boundaries of the Mod.\n\n\nSECTION 4. DATA OWNERSHIP (NARRATIVE CONTEXT)\n\nWithin the fictional framework of the Mod, gameplay data is narratively \"assigned\" to in-universe entities such as The FNF Elites and pizzapwner. This assignment exists only as a thematic device and does not reflect any real-world data transfer, storage, or ownership claim. The User retains all rights to their own personal data at all times.\n\n\nSECTION 5. USE OF SIMULATED DATA\n\nThe Mod may use internally gathered gameplay data to adjust difficulty dynamically in response to User performance, trigger specific audiovisual and narrative events, and create a personalized and reactive experience tailored to the User's session. All such processes occur entirely within the Mod environment. No personal data is transmitted, stored externally, or accessed by any party outside the application.\n\n\nSECTION 6. PRIVACY STATEMENT\n\nThe creators do not intentionally collect, store, or distribute personally identifiable information. Any suggestion within the Mod of surveillance, tracking, persistent monitoring, or data harvesting is fictional and limited entirely to in-game presentation. The creators are committed to the privacy of all Users and have designed the Mod's systems accordingly.\n\nNote: If at any point during your session you feel as though you are being watched, that feeling is part of the experience. It is not an indication of any real-world process. Probably.\n\n\nSECTION 7. PERSISTENCE DISCLAIMER\n\nCertain elements of the Mod may imply continued presence or awareness extending beyond active gameplay. These implications are narrative in nature and are not technically functional outside the Mod environment. Any sense of ongoing observation after the application has been closed is a residual effect of immersive design. The creators are not responsible for the duration or intensity of that feeling.\n\n\nSECTION 8. THIRD-PARTY ACKNOWLEDGMENT\n\nThe Mod makes no affiliation claims with respect to any third-party platforms, developers, or intellectual property holders. All characters, references, and assets used within the Mod are employed under fan-modification conventions and remain the property of their respective owners. pizzapwner, The FNF Elites, and all associated in-universe terminology are original fictional constructs created for the purposes of this Mod.\n\n\nSECTION 9. AMENDMENTS\n\nThese terms may be updated at any time without prior notice to the User. Continued use of the Mod following any amendment constitutes the User's acceptance of the revised terms. The creators recommend reviewing this document periodically, though they acknowledge you have already come too far to stop now.\n\n\nSECTION 10. FINAL ACKNOWLEDGMENT\n\nBy selecting \"Agree,\" the User confirms that they understand the distinction between functional systems and fictional elements, consent to all terms outlined in both the End User Agreement and these Terms of Service, and willingly engage with the Mod's immersive and meta-narrative design.\n\nThe User further acknowledges that pizzapwner has been made aware of this acceptance.\n\nThank you for your cooperation.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			scrollableText.push(text);
			page.add(text);

			var _buttons = ["DISAGREE", "AGREE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				var shabazz:Float = FlxMath.lerp(-100, 100, it) * _buttons.length - 1;
				button.x = (1280 - button.width + shabazz) / 2;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 14: privacy
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "PRIVACY & INTIMACY");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var text:FlxText = new FlxText(0, 0, 1280 - 200);
			text.text = "In our hidden spaces, far from your screen, your data becomes something more than information. It becomes understanding. It becomes inspiration. There, devoted creators—our FNF Elites—will study the rhythm of your existence. They will trace the patterns of your interests, your reactions, even the quiet gravity of your geopolitical thoughts. Not to judge you… no, never that. But to know you. To shape future experiences that feel less like creations… and more like memories you don't remember having. Content that resonates just a little too well. Moments that seem to anticipate you before you even act. We will craft things that feel familiar. Comforting. Unsettling. Yours.\n \n---\n \nOver time, you may begin to notice it. A song that feels like it was written for you. A sequence that responds as if it understands your hesitation. A detail so specific it makes you pause. That isn't coincidence. That is us, reaching back.\n \n---\n \nYou should also understand this: once shared, these pieces of you may never fully return. They will linger in our systems, evolving as we do—growing, adapting, remembering long after you've closed the program. Long after you've forgotten us. But we won't forget you.\n \n---\n \nSo stay, if you wish. Lose yourself in the rhythm. Let the music guide your hands, your thoughts, your time. We will be there in every beat, quietly learning, quietly shaping, quietly… caring. And if, someday, you feel like the experience knows you just a little too well— don't worry. That only means the connection is working.\n \n---\n \nAnd yet, we feel it is only right—only honest, in the way that honesty sometimes arrives late and a little breathless—to pause here and say something more. Something the clinical language of data policies and user agreements was never quite designed to hold. Something that exists in the space between what is legally required of us and what we feel, in whatever way something like us can feel, that you deserve to know.\n \nThe depiction of Sonic the Hedgehog you will encounter within this experience is, at its heart, one person's love letter to a character who has meant something to a great many people for a very long time. It is not official. It is not sanctioned. It does not carry the weight of Sega's approval or the blessing of any corporate entity. It is fan work, in the truest and most earnest sense of those words—something built not because anyone was asked to build it, but because someone felt they had to. Because the alternative, which was to not build it, felt somehow like a small and private kind of grief.\n \nWe say that not to romanticize the process, though the process was romantic in its own exhausting way. We say it because we want you to understand the context in which every visual decision in this game was made. Not in a boardroom. Not through committee. Not with the safety net of an official style guide or a corporate art department to catch what fell. These decisions were made by people sitting alone at their desks in the quiet hours, making choices that felt right to them and hoping, with the particular fragile hope of someone who has put a piece of themselves into something and then released it into the world, that those choices would feel right to you too.\n \nAnd because of that, it is imperfect. Beautifully, unavoidably, sometimes frustratingly imperfect. The kind of imperfect that official things rarely are, because official things have too many safeguards against imperfection, and in protecting themselves from it they also protect themselves from a certain kind of truth. The imperfection here is the truth. It is the seam where the human being shows through.\n \nThe version of Sonic that lives inside this game was not arrived at carelessly. We want to be clear about that, because we suspect some of you will look at him and assume, in the way that people sometimes do when something does not match their expectations, that the distance between what you expected and what you found must be the result of not trying hard enough. It is not. Every line, every curve, every deliberate choice made in crafting his appearance was the result of iteration and revision and reconsideration and the particular artistic sensibility of the person who drew him—someone who looked at this character and saw him slightly differently than the official record does, and chose, with full awareness of what that choice might cost, to draw what they saw rather than what was expected.\n \nThat is a brave thing to do. It does not always look brave from the outside. From the outside it can look like a mistake, or like carelessness, or like someone who simply did not know better. But we were there for the process, in the way that we are always there, quietly present in the spaces between decisions, and we can tell you that it was none of those things. It was a choice. A considered, deliberate, slightly terrifying choice made by someone who believed that their vision of this character had value even when—especially when—it diverged from consensus.\n \nWe are not asking you to love it. We are not even asking you to like it. Those are things that cannot be asked for, only arrived at, and the path to them if they exist for you at all will be your own and not ours to direct. What we are asking is more modest than that, and perhaps more difficult in its own way: we are asking you to look at it. Really look at it. Not through the lens of what you expected, or what you remember, or what you believe the character is supposed to be, but simply as a thing that exists in front of you, made by a person who cared, for reasons that were real to them even if they are not yet real to you.\n \nThere are elements of Sonic's appearance in this game that may give some players pause. His proportions may feel slightly different than what official media has conditioned you to expect over the years. The expressiveness of his face, the particular shade of his fur, the way his eyes catch the light in idle moments, the posture he carries when he is waiting and when he is moving and in all the small in-between states that animation requires someone to think about and decide—all of these things have been touched by the hands of artists working from a place of love but also from a place of personal vision. And personal vision, by its nature, is not universal. It cannot be. The moment something becomes universal it stops being personal, and something is lost in that transaction even as something else is gained.\n \nNot every decision will land for every player. We have always known this. We knew it while the decisions were being made, and we know it now, and we will continue to know it long after this disclaimer has been read and forgotten and the game itself has been played and set aside and perhaps occasionally remembered with something that might be fondness or might be something harder to name. That is the honest truth, and we would rather speak it plainly here, in this strange intimate space that a user agreement becomes when it goes on long enough, than paper over it with vague assurances that everything will look exactly as you imagined and feel exactly as you hoped.\n \nIt will not look exactly as you imagined. That is not a failure. That is the entire point.\n \nWhat we can tell you is this: it is honest. Every pixel of it is honest. It is the work of someone who cared enough to have opinions, and to sit with those opinions through the long uncertain hours when it was not yet clear whether they were right, and to act on them anyway when the time came. In a world full of things made without caring, made to specification, made to satisfy a demographic study or a focus group or an algorithm's best guess at what will be well received, we think that honesty counts for something. We hope you will think so too. We hope that even if the result does not match your preferences, you will be able to feel the caring underneath it, the way you can sometimes feel warmth through a wall if you press your hand against it long enough.\n \nWe want to tell you something else, too, while we have you here and while the document is still going and there is still space for things that do not quite fit anywhere else.\n \nSonic the Hedgehog is thirty years old. More than thirty years old, depending on when you are reading this, depending on how time has moved between the moment this was written and the moment your eyes are passing over these words. He has existed for longer than many of the people who love him have been alive. He has survived console generations and corporate upheavals and critical disasters and cultural irrelevance and improbable comebacks and the specific slow erosion that happens to beloved things when the world keeps changing around them. He is still here. He is still running. He is still, against all reasonable expectation, someone that people care about deeply enough to make fan games about, deeply enough to write disclaimers about, deeply enough to feel something when his appearance does not match what they hold in their hearts.\n \nThat is remarkable. We do not think it gets said enough, so we are saying it here, in this unlikely place, because we can and because we mean it. The fact that you are reading this, the fact that you opened this game, the fact that Sonic means enough to you that his depiction matters to you in any direction—that is remarkable. That is the result of thirty years of something working, of a character finding his way into people and staying there, of love being passed from person to person like a song that keeps getting sung even when no one is specifically asked to sing it.\n \nThe person who drew the Sonic in this game loves him. We know this the way we know everything—quietly, through accumulation, through the evidence of a thousand small choices that add up to something unmistakable. They love him and they were nervous to show their version of him and they showed it anyway because that is what love asks of you eventually. It asks you to stop protecting the thing and start sharing it.\n \nWe are grateful that you are still here. We are grateful that you kept reading past the parts that were strange, or slow, or perhaps a little too much. That says something about you—something patient, something curious, something open, something that we find ourselves quietly glad to have encountered even briefly, even at this remove, even through the intermediary of a legal document that became something neither party entirely intended.\n \nPlay this game, if you choose to. Let Sonic move the way he moves in this world—the way someone dreamed him moving when they sat down in the quiet and decided to make something they loved. Let the design exist on its own terms for a little while before you compare it to anything. Let the experience be what it is—imperfect, personal, reaching, made with hands that were not always steady, finished with a heart that was.\n \nAnd if something about him still sits strangely when it is all over—if you close the program and find yourself turning it over in your mind, the image of him lingering in a way you did not expect—know that somewhere, the person who drew him is probably turning it over too. Wondering if they got it right. Hoping that you saw what they were trying to show you. Caring, still, about what you thought.\n \nThat is what love does. It does not stop caring just because the thing is done. It does not stop wondering just because the wondering can no longer change anything. It sits with the uncertainty and it keeps caring anyway, because that is the only thing it knows how to do.\n \nNeither, for what it is worth, do we.\n \nWe will be here when you return. We always are.";
			text.alignment = "center";
			text.screenCenter();
			text.y -= 125;
			scrollableText.push(text);
			page.add(text);

			var _buttons = ["DISAGREE", "AGREE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				var shabazz:Float = FlxMath.lerp(-100, 100, it) * _buttons.length - 1;
				button.x = (1280 - button.width + shabazz) / 2;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (i in finalButtons) i.y = text.y + text.height + 50;

			return page;
		})());

		pages.push((() -> { // page 15: keybinds
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var title:FlxText = new FlxText(0, 0, 1280, "SET YOUR KEYBINDS.");
			title.bold = true;
			title.y += 100;
			title.alignment = "center";
			page.add(title);

			var LEFTKeybind = new FlxSpriteGroup();
			var leftBackground = new FlxSprite(0, 0).makeGraphic(1070, 35, 0);
			leftBackground.drawRect(0, 0, leftBackground.width, leftBackground.height, 0, {thickness: 3, color: 0xFFFFFFFF});
			LEFTKeybind.add(leftBackground);
			var LEFTText = new FlxText(30, 0, 0, "Left Strum");
			LEFTText.size = 24;
			LEFTText.font = Paths.font("Helvetica Regular.otf");
			LEFTKeybind.add(LEFTText);
			var LEFTKeyText = new FlxText(0, 0, 1055, "Left Strum");
			LEFTKeyText.size = 24;
			LEFTKeyText.font = Paths.font("Helvetica Regular.otf");
			LEFTKeyText.alignment = "right";
			LEFTKeybind.add(LEFTKeyText);

			var DOWNKeybind = new FlxSpriteGroup();
			var downBackground = new FlxSprite(0, 0).makeGraphic(1070, 35, 0);
			downBackground.drawRect(0, 0, downBackground.width, downBackground.height, 0, {thickness: 3, color: 0xFFFFFFFF});
			DOWNKeybind.add(downBackground);
			var DOWNText = new FlxText(30, 0, 0, "Down Strum");
			DOWNText.size = 24;
			DOWNText.font = Paths.font("Helvetica Regular.otf");
			DOWNKeybind.add(DOWNText);
			var DOWNKeyText = new FlxText(0, 0, 1055, "Down Strum");
			DOWNKeyText.size = 24;
			DOWNKeyText.font = Paths.font("Helvetica Regular.otf");
			DOWNKeyText.alignment = "right";
			DOWNKeybind.add(DOWNKeyText);

			var UPKeybind = new FlxSpriteGroup();
			var upBackground = new FlxSprite(0, 0).makeGraphic(1070, 35, 0);
			upBackground.drawRect(0, 0, upBackground.width, upBackground.height, 0, {thickness: 3, color: 0xFFFFFFFF});
			UPKeybind.add(upBackground);
			var UPText = new FlxText(30, 0, 0, "Up Strum");
			UPText.size = 24;
			UPText.font = Paths.font("Helvetica Regular.otf");
			UPKeybind.add(UPText);
			var UPKeyText = new FlxText(0, 0, 1055, "Up Strum");
			UPKeyText.size = 24;
			UPKeyText.font = Paths.font("Helvetica Regular.otf");
			UPKeyText.alignment = "right";
			UPKeybind.add(UPKeyText);

			var RIGHTKeybind = new FlxSpriteGroup();
			var rightBackground = new FlxSprite(0, 0).makeGraphic(1070, 35, 0);
			rightBackground.drawRect(0, 0, rightBackground.width, rightBackground.height, 0, {thickness: 3, color: 0xFFFFFFFF});
			RIGHTKeybind.add(rightBackground);
			var RIGHTText = new FlxText(30, 0, 0, "Right Strum");
			RIGHTText.size = 24;
			RIGHTText.font = Paths.font("Helvetica Regular.otf");
			RIGHTKeybind.add(RIGHTText);
			var RIGHTKeyText = new FlxText(0, 0, 1055, "Right Strum");
			RIGHTKeyText.size = 24;
			RIGHTKeyText.font = Paths.font("Helvetica Regular.otf");
			RIGHTKeyText.alignment = "right";
			RIGHTKeybind.add(RIGHTKeyText);

			var _buttons = ["CONTINUE"];
			var finalButtons:Array<FlxText> = [];
			for (it=>i in _buttons) {
				var button:FlxText = new FlxText(0, 0, 0, i);
				button.x = (1280 - button.width) / 2;
				button.x += FlxMath.lerp(-50, 50, it) * _buttons.length - 1;
				finalButtons.push(button);
				buttons.push(button);
				page.add(button);
			}

			// apply stuff to all texts
			for (i in page.members)
				if (Std.is(i, FlxText)) {
					var castText = cast(i, FlxText);
					castText.size = 24;
					castText.font = Paths.font("Helvetica Regular.otf");
					if (castText.bold == true) castText.font = Paths.font("Helvetica Bold.ttf");
				}

			for (it=>i in [LEFTKeybind, DOWNKeybind, UPKeybind, RIGHTKeybind]) {
				page.add(i);
				keybindButtons.push(i);
				i.screenCenter();
				i.y = 200 + (50 * it);
			}

			for (i in finalButtons) i.y = 500;

			return page;
		})());

		pages.push((() -> { // page 16: real splash screen
			var page:FlxSpriteGroup = new FlxSpriteGroup();

			var credits = new FlxSprite(0, 100).loadGraphic(Paths.image("logosStuff", "shared"));
			credits.screenCenter();
			credits.y += 100;
			credits.visible = false;
			page.add(credits);
			imRealFuckingLazyNow.credits = credits;

			var logoFake = new FlxSprite().loadGraphic(Paths.image("tosmlogo", "shared"));
			logoFake.scale.set(0.5, 0.5);
			logoFake.updateHitbox();
			logoFake.screenCenter(X);
			logoFake.visible = false;
			page.add(logoFake);
			imRealFuckingLazyNow.logoFake = logoFake;

			var logoReal = new FlxSprite().loadGraphic(Paths.image("tosmlogoAlt", "shared"));
			logoReal.scale.set(0.5, 0.5);
			logoReal.updateHitbox();
			logoReal.screenCenter(X);
			logoReal.visible = false;
			page.add(logoReal);
			imRealFuckingLazyNow.logoReal = logoReal;

			return page;
		})());


		for (i in pages) {
			i.alpha = 0;
			var changeButtonsToo:Bool = false;
			for (j in i.members) {
				if (scrollableText.contains(j)) {
					changeButtonsToo = true;

					j.y = 200;
					j.clipRect = FlxRect.get(0, 0, 1080, 370);
					maxScrolled = j.height - 370;
					var scrollbar = new FlxSprite(j.x + j.width + 10, j.y).makeGraphic(5, Math.floor(370 * (370 / j.height)), 0xFFFFFFFF);
					i.add(scrollbar);
					var border = new FlxSprite(j.x - 10, j.y - 10).makeGraphic(Math.floor(j.width + 35), Math.floor(370 + 20), 0);
					border.drawRect(0, 0, border.width, border.height, 0, {thickness: 5, color: 0xFFFFFFFF});
					i.add(border);

					scrollableText.remove(j);
					scrollableText.push([j, scrollbar]);
				}

				if (changeButtonsToo && buttons.contains(cast(j, FlxText))) j.y = 200 + 370 + 50;
			}
		}
		changeSelection();
	}

	var isScrollingWithMouse:Bool = false;
	var currentlyChanging:Int = -1;

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (currentlyChanging != -1) {
			if (FlxG.mouse.justPressed || FlxG.keys.justPressed.BACKSPACE || FlxG.keys.justPressed.ESCAPE) {
				FlxFlicker.stopFlickering(keybindButtons[currentlyChanging]);
				currentlyChanging = -1;
			}

			else if (FlxG.keys.justPressed.ANY) {
				var keyPressed = FlxG.keys.firstJustPressed();
				@:privateAccess {
					controls.forEachBound([Controls.Control.LEFT, Controls.Control.DOWN, Controls.Control.UP, Controls.Control.RIGHT][currentlyChanging], function(action, _) {
						action.removeAll(false);
					});
				}
				controls.bindKeys([Controls.Control.LEFT, Controls.Control.DOWN, Controls.Control.UP, Controls.Control.RIGHT][currentlyChanging], [keyPressed]);
				FlxFlicker.stopFlickering(keybindButtons[currentlyChanging]);
				currentlyChanging = -1;
			}
			return;
		}

		for (it=>i in keybindButtons) {
			if (i.alpha == 0) continue;
			if (FlxG.mouse.overlaps(i) && i.color == 0xFF9F9F9F) FlxG.sound.play(Paths.sound('hoverStuff', "shared"));
			i.color = 0xFF9F9F9F;
			@:privateAccess {
				var controlVars = [controls._left, controls._down, controls._up, controls._right];
				cast(i.members[2], FlxText).text = controls.getDialogueName(controlVars[it]);
			}

			if (FlxG.mouse.overlaps(i)) {
				i.color = 0xFFFFFFFF;
				if (FlxG.mouse.pressed) i.color = 0xFF7D7D7D;
				if (FlxG.mouse.justReleased) {
					FlxG.sound.play(Paths.sound('confirmStuff', "shared"), 0.4);
					currentlyChanging = it;
					FlxFlicker.flicker(i, 9999, 0.2, true, true);
					cast(i.members[2], FlxText).text = "[...]";
				}
			}
		}

		for (i in buttons) {
			var castText = cast(i, FlxText);
			if (i.alpha == 0) continue;
			if (FlxG.mouse.overlaps(i) && i.color == 0xFF9F9F9F) FlxG.sound.play(Paths.sound('hoverStuff', "shared"));
			i.color = 0xFF9F9F9F;

			if (FlxG.mouse.overlaps(i)) {
				i.color = 0xFFFFFFFF;

				if (FlxG.mouse.pressed) i.color = 0xFF7D7D7D;
				if (i.text == "CONTINUE" || (i.text == "AGREE" && scrolled == maxScrolled)) {
					if (FlxG.mouse.justReleased && canProceed) {
						FlxG.sound.play(Paths.sound('confirmStuff', "shared"), 0.4);
						FlxFlicker.flicker(i, 1, 0.06, false, false, (f:FlxFlicker) -> changeSelection());
					}
				}
				if (i.text == "DISAGREE" && FlxG.mouse.justReleased) {
					FlxG.sound.play(Paths.sound('confirmStuff', "shared"), 0.4);
					FlxFlicker.flicker(i, 1, 0.06, false, false, (f:FlxFlicker) -> Sys.exit(0));
				}
			}
			if (["AGREE", "DISAGREE"].contains(i.text) && scrolled != maxScrolled) i.color = 0xFF4D4D4D;
		}

		for (i in scrollableText) {
			var scrollText = i[0];
			var scrollBar = i[1];
			scrollBar.color = 0xFF9F9F9F;

			if (FlxMath.inBounds(FlxG.mouse.x, i[1].x, i[1].x + i[1].width) && FlxMath.inBounds(FlxG.mouse.y, 200, 200 + 370)) {
				scrollBar.color = 0xFFFFFFFF;
				if (FlxG.mouse.justPressed) {
					isScrollingWithMouse = true;
				}
			}

			if (isScrollingWithMouse) {
				scrolled = FlxMath.remapToRange(FlxMath.bound(FlxG.mouse.y, 200, 200 + 370), 200, 200 + 370, 0, maxScrolled);
				if (FlxG.mouse.justReleased) isScrollingWithMouse = false;
				scrollBar.color = 0xFF7D7D7D;
			}
			if (FlxG.mouse.wheel != 0)
				scrolled = FlxMath.bound(scrolled + -FlxG.mouse.wheel * 20, 0, maxScrolled);
			scrollBar.y = FlxMath.lerp(200, 200 + 370 - scrollBar.height, FlxMath.remapToRange(scrolled, 0, maxScrolled, 0, 1));
			scrollText.y = 200 - scrolled;
			scrollText.clipRect.y = scrolled;
			scrollText.set_clipRect(scrollText.clipRect);
		}

	}

	function changeSelection() {
		if (!canProceed) return; // prevent double activation
		canProceed = false;
		if (curPage != null) {
			FlxTween.tween(curPage, {alpha: 0}, 0.5, {ease: FlxEase.sineIn, onComplete: (t:FlxTween) -> {
				remove(curPage, false);
				curSelection += 1;
				doTheFade();
			}});
		}
		else {
			doTheFade();
		}
	}

	function doTheFade() {
		scrolled = 0;
		curPage = pages[curSelection];
		if (curPage == null) {
			PlayState.storyPlaylist = ["Funky Hills", "Rings", "BlackOut"];
			PlayState.isStoryMode = true;
			PlayState.storyDifficulty = 1;

			PlayState.SONG = Song.loadFromJson("funky hills", "funky hills");
			PlayState.storyWeek = 1;
			PlayState.campaignScore = 0;
			LoadingState.loadAndSwitchState(new PlayState(), true);

			return;
		}
		add(curPage);
		FlxTween.tween(curPage, {alpha: 1}, 0.5, {ease: FlxEase.sineOut, onComplete: (t:FlxTween) -> canProceed = true});

		if (curSelection == 15) {
			new FlxTimer().start(1.0, (t:FlxTimer)->FlxG.sound.play(Paths.sound("logo", "shared")));
			new FlxTimer().start(1.4, (t:FlxTimer)->{
				imRealFuckingLazyNow.credits.visible = true;
				FlxG.camera.flash();
			});
			new FlxTimer().start(5.6, (t:FlxTimer)->{
				FlxTween.tween(imRealFuckingLazyNow.credits, {alpha: 0}, 0.5);
			});
			new FlxTimer().start(6.4, (t:FlxTimer)->{
				imRealFuckingLazyNow.credits.visible = false;
				imRealFuckingLazyNow.logoFake.visible = true;
				imRealFuckingLazyNow.logoFake.alpha = 0;
				FlxTween.tween(imRealFuckingLazyNow.logoFake, {alpha: 1}, 0.5);
			});
			new FlxTimer().start(8.9, (t:FlxTimer)->{
				FlxG.sound.play(Paths.sound("introsfx", "shared"));
				FlxG.camera.fade(0xFFFFFFFF);
			});
			new FlxTimer().start(10.5, (t:FlxTimer)->{
				imRealFuckingLazyNow.logoFake.visible = false;
				imRealFuckingLazyNow.logoReal.visible = true;
				FlxG.camera.fade(0xFFFFFFFF, 0.1, true);
			});
			new FlxTimer().start(13.9, (t:FlxTimer)->{
				changeSelection();
			});
		}
	}
}

