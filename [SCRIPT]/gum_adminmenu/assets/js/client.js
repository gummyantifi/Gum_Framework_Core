exports('ShowTopNotification', (title, subtext, duration) => {

	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true); // duration
	// struct1.setBigInt64(8, BigInt(sound_dict), true); // Notification sound optional
	// struct1.setBigInt64(16, BigInt(sound), true);

	const string = CreateVarString(10, "LITERAL_STRING", title);
	const string2 = CreateVarString(10, "LITERAL_STRING", subtext);

	const struct2 = new DataView(new ArrayBuffer(48));
	struct2.setBigInt64(8, BigInt(string), true);
	struct2.setBigInt64(16, BigInt(string2), true);


	Citizen.invokeNative("0xA6F4216AB10EB08E", struct1, struct2, 1, 1);
});