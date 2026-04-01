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
import lime.utils.Assets;
using flixel.util.FlxSpriteUtil;


import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;

class SplashScreen extends MusicBeatState {
	var curSelection:Int = 0;
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
			text.text = Assets.getText(Paths.txt('eula', "shared"));
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
			text.text = Assets.getText(Paths.txt('privacy', "shared"));
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
			credits.y += 50;
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

