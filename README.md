# demsg
A bash script GnuPG block text encryption/decryption tool

    demsg
    Decrypt / Encrypt - Message
    by regpar
  
A script for fast encrypting and decrypting short messages with GnuPG block text

    Options:
        -e    encrypt a new message
        -d    decrypt a message
  
    Optional w/ [-e-] encrypt tag:
        -r    define recipient
        -m    define short message
        -c    copy to xclip

Dependencies:

		Bash    http://www.gnu.org/software/bash/
		GnuPG   https://www.gnupg.org/

		Optional:
		xclip   http://sourceforge.net/projects/xclip/

Basic syntax:

	encrypt a new message
		$ sh demsg.sh -e -r <gpg userid> -m <"your message here">
	decrypt a message received  
		$ sh demsg.sh -d


  This script makes it easy to write and read decrypted short messages with GnuPG. The creation of temporary
  files and its deletion is automated. Further the option to copy the encrypted PGP block text is available
  allowing the encrypted text to be pasted on any communication tool.
